class PaymentsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_pay_jp_api_key, only: [:create]

  def create
    product = Product.find(params[:product_id])
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    amount: product.price,
    currency: 'jpy',
    customer: customer_id,
    )
    product.status = 1
    redirect_to root_path
  end

  private
  def set_pay_jp_api_key
    Payjp.api_key = 'sk_test_24a2c3e0fdf0085d0825a6b8'
  end
end
