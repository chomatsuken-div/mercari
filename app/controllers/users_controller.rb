class UsersController < ApplicationController
  before_action :set_search, only: [:show]
  def show
    @parents = Category.all.order("id ASC").limit(13)
    @user = current_user
  end

  def new

  end

  def likes
    likes = current_user.likes
    @products = likes.map(&:product)
  end

  def listings
    # status == 0 出品中
    @products = current_user.seller_products.where(status: 0)
  end

  def in_progress
    # status == 1 取引中
    @products = current_user.seller_products.where(status: 1)
  end

  def completed
    # status == 2 売却済
    @products = current_user.seller_products.where(status: 2)
  end

  def purchase
    # status == 1 取引中
    @products = current_user.buyer_products.where(status: 1)
  end

  def purchased
    # status == 2 購入済
    @products = current_user.buyer_products.where(status: 2)
  end

  private
  def set_search
    @search = Product.ransack(params[:q])
  end

end
