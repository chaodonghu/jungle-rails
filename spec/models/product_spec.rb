require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves successfully when validation criteria met" do
      @category = Category.new
      @product = Product.new ({name: 'Salazar Slytherin\'s Locket', price: 123213, quantity: 2 ,category: @category})
      expect(@product.save).to be true
    end

    it "should have a name" do
      @category = Category.new
      @product = Product.new ({name: nil, price: 200, quantity: 3, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "should have a price" do
      @category = Category.new
      @product = Product.new ({name: 'Death Eater Wand', price: nil, quantity: 1, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "should have a quantity" do
      @category = Category.new
      @product = Product.new ({name: 'Tom Riddle\'s Diary', price: 10000, quantity: nil, category: @category})
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "should have a category" do
      @product = Product.new ({name: 'Helga Hufflepuff\'s Cup', price: 20000, quantity: 1, category: nil})
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
