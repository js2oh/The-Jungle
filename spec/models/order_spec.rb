require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After Creation' do
    before :each do
      @quantity1 = 9
      @quantity2 = 10
      @quantity3 = 8
      @category = Category.find_or_create_by! name: "Spec Category"
      # Setup at least two products with different quantities, names, etc.
      @product1 = Product.create!(
        name: "Product 1",
        category_id: @category.id,
        quantity: @quantity1,
        price: 99.99
      )
      @product2 = Product.create!(
        name: "Product 2",
        category_id: @category.id,
        quantity: @quantity2,
        price: 10.10
      )
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(
        name: "Not in Order",
        category_id: @category.id,
        quantity: @quantity3,
        price: 77.77
      )
    end

    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema, and model definition for what is required)
      @order = Order.new(
        email: "canadaGoose@gmail.com",
        total_cents: 110.09,
        stripe_charge_id: "stripe_charge_id",
      )
      # 2. build line items on @order
      cart = [@product1, @product2].map {|product| { product: product, quantity: 3 } }
      cart.each do |entry|
        product = entry[:product]
        quantity = entry[:quantity]
        @order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 4. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(@quantity1 - 3)
      expect(@product2.quantity).to eq(@quantity2 - 3)
      @order.line_items.each do |line_item|
        line_item.destroy
      end
      @order.destroy
    end

    it 'does not deduct quantity from products that are not in the order' do
      # 1. initialize order with necessary fields (see orders_controllers, schema, and model definition for what is required)
      @order = Order.new(
        email: "canadaGoose@gmail.com",
        total_cents: 110.09,
        stripe_charge_id: "stripe_charge_id",
      )
      # 2. build line items on @order
      cart = [@product1, @product2].map {|product| { product: product, quantity: 3 } }
      cart.each do |entry|
        product = entry[:product]
        quantity = entry[:quantity]
        @order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 4. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to eq(@quantity3)
      @order.line_items.each do |line_item|
        line_item.destroy
      end
      @order.destroy
    end
  end
end
