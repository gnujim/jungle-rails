require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new
    end

    it 'should be invalid without a name' do
      product = Product.create(name: nil, price: 13, quantity: 2, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'should be invalid without a price' do
      product = Product.create(name: 'a', price: nil, quantity: 2, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.messages[:price]).to include('can\'t be blank')
    end

    it 'should be invalid without a quantity' do
      product = Product.create(name: 'a', price: 13, quantity: nil, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'should be invalid without a category' do
      product = Product.create(name: 'a', price: 13, quantity: 2, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end
