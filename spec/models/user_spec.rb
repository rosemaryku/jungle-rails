require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

  it 'creates a new user if all fields are valid' do
    @user = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    @user.save
    expect(@user.valid?).to be true
  end

  it 'does not create a new user if first name is missing' do
    @user = User.create(
      first_name: nil, 
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:first_name]).to include "can't be blank"
  end

  it 'does not create a new user if last name is missing' do
    @user = User.create(
      first_name: 'Adam',
      last_name: nil,
      email: 'adam.smith@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:last_name]).to include "can't be blank"
  end

  it 'does not create a new user if email is missing' do
    @user = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: nil,
      password: 'password',
      password_confirmation: 'password',
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:email]).to include "can't be blank"
  end

  it 'does not create a new user if password is missing' do
    @user = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: nil,
      password_confirmation: nil,
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:password]).to include "can't be blank"
  end

  it 'does not create a new user if passwords do not match' do
    @user = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: 'password',
      password_confirmation: 'wrongpassword',
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:password_confirmation]).to include "doesn't match Password"
  end

  it 'does not create a new user if passwords is not min 6 characters in length' do
    @user = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: 'pass',
      password_confirmation: 'pass',
    )
    @user.save
    expect(@user.valid?).to be false
    expect(@user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
  end

  it 'does not create a new user if email already exists in database' do
    @user1 = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.smith@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    @user1.save

    @user2 = User.create(
      first_name: 'Adam',
      last_name: 'Smith',
      email: 'adam.SMITH@example.com',
      password: 'password2',
      password_confirmation: 'password2',
    )
    @user2.save

    expect(@user1.valid?).to be true
    expect(@user2.valid?).to be false
    expect(@user2.errors.messages[:email]).to include "has already been taken"
  end
end 


describe '.authenticate_with_credentials' do
  it 'should work with valid credentials' do
    @user =
      User.new(
        first_name: 'Rosemary',
        last_name: 'Ku',
        email: 'rosemary.ku@gmail.com',
        password: 'password',
        password_confirmation: 'password',
      )
    @user.save
    loggedUser =
      User.authenticate_with_credentials(@user.email, @user.password)

    expect(loggedUser.id).to be (@user.id)
  end

  it 'should not be sensitive to case in user email' do
    @user =
      User.new(
        first_name: 'Rosemary',
        last_name: 'Ku',
        email: 'rosemary.ku@gmail.com',
        password: 'password',
        password_confirmation: 'password',
      )
    @user.save
    loggedUser =
      User.authenticate_with_credentials(
        'ROSEMARY.ku@gmail.com',
        @user.password,
      )

    expect(loggedUser.id).to be (@user.id)
  end

  it 'should ignore whitespace in email' do
    @user =
      User.new(
        first_name: 'Rosemary',
        last_name: 'Ku',
        email: 'rosemary.ku@gmail.com',
        password: 'password',
        password_confirmation: 'password',
      )
    @user.save
    loggedUser =
      User.authenticate_with_credentials(
        ' rosemary.ku@gmail.com',
        @user.password,
      )
    expect(loggedUser.id).to be (@user.id)
  end
 end
end

