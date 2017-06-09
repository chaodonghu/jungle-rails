# require 'pry'

class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews
    # @reviews2 = Review.where product_id: @product.id
    # binding.pry
    @review = Review.new
  end

end
