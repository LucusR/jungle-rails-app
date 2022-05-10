require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it "Will save product if valid" do
      @category = Category.new(name: "Test_Category_Name")
      @product = Product.new(name: "Test_Product_Name", price_cents: 5000, quantity: 50, :category => @category)
      @product.valid?
  end

  it "Validates that the product has a name" do
    @category = Category.new(name: "Test_Category_Name")
    @product = Product.new(price_cents: 5000, quantity: 50, :category => @category)
    @product.valid?
    expect(@product.errors[:name]).to include("can't be blank")
  end

  it "Validates that the product has a price" do
    @category = Category.new(name: "Test_Category_Name")
    @product = Product.new(name: "Test_Product_Name", quantity: 50, :category => @category)
    @product.valid?
    expect(@product.errors[:price]).to include("can't be blank")
  end

  it "Validates that the product has a quantity" do
    @category = Category.new(name: "Test_Category_Name")
    @product = Product.new(name: "Test_Product_Name", price_cents: 5000, :category => @category)
    @product.valid?
    expect(@product.errors[:quantity]).to include("can't be blank")
  end

  it "Validates that the product has a category" do
    @category = Category.new(name: "Test_Category_Name")
    @product = Product.new(name: "Test_Product_Name", price_cents: 5000, quantity: 50)
    @product.valid?
    expect(@product.errors[:category]).to include("can't be blank")
  end
end
end