require 'rails_helper'
require 'simplecov'
SimpleCov.start 'rails'
RSpec.describe Product, type: :model do
  describe 'validations' do
    context "invalid cases" do
    it "should not validate without presence_of name" do
      product_without_name=Product.new(price:100,category:"shoes")
      expect(product_without_name).to_not be_valid
    end
    it "should not validate without presence_of price" do
      product_without_price=Product.new(name:"nike",category:"shoes")
      expect(product_without_price).to_not be_valid
    end
    it "should not validate without presence_of category" do
      product_without_category=Product.new(name:"nike",price:1000)
      expect(product_without_category).to_not be_valid
    end
    describe 'association' do
      it "has many orders" do
      t=Product.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end
    it "has many order_items" do
      t=Product.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end
  end
  context "valid case" do
     it "all attributes are present" do
        product_valid=Product.new(name:"nike",price:1000,category:"Shoes")
        expect(product_valid).to be_valid
     end
  end
  end
  end
end
