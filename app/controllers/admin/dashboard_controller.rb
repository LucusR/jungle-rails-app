class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['admin_username'], password: ENV['admin_password']

  def show
    @product_count = Product.count
    @category_count = Product.group(:category_id).count
  end
end