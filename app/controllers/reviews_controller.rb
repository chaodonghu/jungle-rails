class ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    # byebug
    @review = @product.reviews.new(rating: params[:rating].to_i, description: params[:review][:description])
    @review.user = current_user

    if @review.save!
      redirect_to product_path product_id
    else
      redirect_to root_path
    end

  end

  private
  def product_id
    params[:product_id]
  end
end
