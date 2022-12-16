require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    num = 0

    before(:each) do
      num += 1
      @category = Category.find_or_create_by! name: "Spec Category #{num}"
    end

    after(:each) do
      @category.destroy
    end

    it "should allow a product be created with full parameters" do
      @product = @category.products.create(
        name: "Spec Product",
        quantity: 9,
        price: 99.99
      )
      expect(@product).to be_valid
      expect(@product.errors.full_messages.length).to eq(0)
      @product.destroy
    end

    it "should not let a product be created without a name" do
      noname = @category.products.create(
        quantity: 9,
        price: 99.99
      )
      expect(noname).not_to be_valid
      expect(noname.errors.full_messages.include?("Name can't be blank")).to eq(true)
    end

    it "should not let a product be created without a price" do
      priceless = @category.products.create(
        name: "Spec Product",
        quantity: 9
      )
      expect(priceless).not_to be_valid
      expect(priceless.errors.full_messages.include?("Price can't be blank")).to eq(true)
    end

    it "should not let a product be created without a quantity" do
      empty = @category.products.create(
        name: "Spec Product",
        price: 99.99
      )
      expect(empty).not_to be_valid
      expect(empty.errors.full_messages.include?("Quantity can't be blank")).to eq(true)
    end

    it "should not let a product be created without a category" do
      uncategorized = Product.create(
        name: "Spec Product",
        quantity: 9,
        price: 99.99
      )
      expect(uncategorized).not_to be_valid
      expect(uncategorized.errors.full_messages.include?("Category can't be blank")).to eq(true)
    end

    # Each example is run in isolation of others.
    # Therefore, each example will need its own @category created and then @product initialized with that category

    # Create an initial example that ensures that a product with all four fields set will save successfully
  end
end
