class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def likes
    likes = current_user.likes
    @products = likes.map(&:product)
  end

  def listings
    @products = current_user.products.where(transaction_status: 'listing')
  end

  def in_progress
    @products = current_user.products.where(transaction_status: 'in_progress')
  end

  def completed
    @products = current_user.products.where(transaction_status: 'completed')
  end

  def purchase
    @products = Product.is_purchased(current_user.id)
                       .where(transaction_status: 'in_progress')
  end

  def purchased
    @products = Product.is_purchased(current_user.id)
                       .where(transaction_status: 'completed')
  end
end
