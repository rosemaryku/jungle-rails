require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'save product to database if all fields are valid' do
      @category = Category.create(name: "Food")
      @product = Product.new(
        name: 'Apple',
        price: 100,
        quantity: 1,
        category: @category,
      )
      @product.save
      expect(@product.valid?).to be true

    end
    
    it 'does not save a product that has no name' do
      @category = Category.create(name: "Food")
      @product = Product.new(
        name: nil,
        price: 100,
        quantity: 1,
        category: @category,
      )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:name]).to include "can't be blank"
    end

    it 'does not save a product that has no price' do
      @category = Category.create(name: "Food")
      @product = Product.new(
        name: 'Apple',
        quantity: 1,
        category: @category,
      )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:price]).to include "can't be blank"
    end

    it 'does not save a product that has no quantity' do
      @category = Category.create(name: "Food")
      @product = Product.new(
        name: 'Apple',
        price: 100,
        quantity: nil,
        category: @category,
      )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:quantity]).to include "can't be blank"
    end

    it 'does not save a product that has no category' do
      @product = Product.new(
        name: 'Apple',
        price: 100,
        quantity: 1,
        category: nil,
      )
      @product.save
      expect(@product.valid?).to be false
      expect(@product.errors.messages[:category]).to include "can't be blank"
    end

  end
end
