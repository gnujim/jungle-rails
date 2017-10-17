require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    
    # it 'should be invalid without all fields' do
    #   user = User.create(first_name: nil, last_name: 'a', email: 'a@a.com', password: 'a', password_confirmation: 'a')
    #   expect(user).to_not be_valid
    # end

    # it 'should be invalid without email, first name, and last name' do
    #   user = User.new(first_name: nil, last_name: nil, email: nil, password: 'a', password_confirmation: 'a')
    #   expect(user).to_not be_valid
    #   expect(user.errors.full_messages)
    # end

    # it 'should be invalid without a first_name' do
    #   product = Product.create(name: nil, price: 13, quantity: 2, category: @category)
    #   expect(product).to_not be_valid
    #   expect(product.errors.messages[:name]).to include('can\'t be blank')
    # end

    it 'should be invalid without unique email' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdf', password_confirmation: 'asdf')
      user2 = User.create(first_name: 'a', last_name: 'a', email: 'A@A.com', password: 'asdf', password_confirmation: 'asdf')
      expect(user2).to_not be_valid
    end

    it 'should be invalid without matching passwords' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdfe', password_confirmation: 'asdf')
      # expect(user.password).to eql user.password_confirmation
      # expect(user.errors.messages[:password]).to include('doesn\'t match Password') 
      expect(user).to_not be_valid
    end

    it 'should be invalid if not minimum length' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'a', password_confirmation: 'a')
      expect(user.password).to_not be <= 3
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should be invalid if bad credentials' do
      User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdf', password_confirmation: 'asdf')
      user = User.authenticate_with_credentials('a@a.com', 'vhgvhgv')
      expect(user).to be nil
    end

    it 'should be valid if good credentials ' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdf', password_confirmation: 'asdf')
      validUser = User.authenticate_with_credentials('a@a.com', 'asdf')
      expect(validUser).to eql user
    end

    it 'should be valid if email has whitespace' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdf', password_confirmation: 'asdf')
      validUser = User.authenticate_with_credentials('  a@a.com  ', 'asdf')
      expect(validUser).to eql user
    end

    it 'should be valid if email is case insensitive' do
      user = User.create(first_name: 'a', last_name: 'a', email: 'a@a.com', password: 'asdf', password_confirmation: 'asdf')
      validUser = User.authenticate_with_credentials('a@A.CoM', 'asdf')
      expect(validUser).to eql user
    end

  end
end
