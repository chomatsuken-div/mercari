class CardsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_payjp_api_key, only: [:create]

  def new
  end

  def create
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:pay_id]
    )
    card = Card.new(
      pay_id: params[:pay_id],
      customer_id: customer.id,
      user_id: current_user.id
    )
  card.save
  end

  private

  def set_payjp_api_key
    Payjp.api_key = 'sk_test_24a2c3e0fdf0085d0825a6b8'
  end
end
