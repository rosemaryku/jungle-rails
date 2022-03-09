class Admin::DashboardController < ApplicationController
    http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
    
  def show
    @num_of_products = Product.count
    @num_of_categories = Category.count
  end
end
