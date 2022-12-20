require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    num = 0

    before(:each) do
      num += 1
      @category = Category.find_or_create_by! name: "Spec Category #{num}"
    end

    it "should allow a product be created with full parameters" do
      product = @category.products.create(
        name: "Spec Product",
        quantity: 9,
        price: 99.99
      )
      expect(product).to be_valid
      expect(product.errors.full_messages.length).to eq(0)
    end

    it "should not let a product be created without a name" do
      product = @category.products.create(
        name: "",
        quantity: 9,
        price: 99.99
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.include?("Name can't be blank")).to eq(true)
    end

    it "should not let a product be created without a price" do
      product = @category.products.create(
        name: "Spec Product",
        quantity: 9
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.include?("Price can't be blank")).to eq(true)
    end

    it "should not let a product be created without a quantity" do
      product = @category.products.create(
        name: "Spec Product",
        price: 99.99
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.include?("Quantity can't be blank")).to eq(true)
    end

    it "should not let a product be created without a category" do
      product = Product.create(
        name: "Spec Product",
        quantity: 9,
        price: 99.99
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.include?("Category can't be blank")).to eq(true)
    end
  end
end
