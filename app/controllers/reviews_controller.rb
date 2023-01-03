class ReviewsController < ApplicationController

  before_action :require_login

  def create
    @product = Product.find params[:product_id]
    @product.reviews.new(
      user: current_user,
      description: params[:description],
      rating: params[:rating].to_i
    )
    if @product.save
      redirect_to @product, notice: 'Review created!'
    else
      redirect_to @product, notice: 'Review failed...'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @product = Product.find params[:product_id]
    @review.destroy
    redirect_to @product, notice: 'Review deleted!'
  end

  private

  def require_login
    unless current_user?
      flash[:error] = "You must be logged in to access this resource"
      redirect_to '/login'
    end
  end

end
