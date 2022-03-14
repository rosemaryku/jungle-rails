require 'rails_helper'

RSpec.feature 'AddToCarts', type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario 'They can update the cart by clicking the add to cart button' do
    visit root_path
    expect(page).to have_content('My Cart (0)')
    first('.product button').click
    expect(page).to have_content('My Cart (1)')
  end
end