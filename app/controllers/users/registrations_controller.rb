# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :validation_profile, only: [:phone]
  before_action :validation_phone, only: [:address]
  before_action :validation_address, only: [:card]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def profile
    @user = User.new
  end

  def phone
    session['user'] = profile_params
    @user = User.new
  end

  def address
    @user = User.new
    @user.build_address
  end

  def card
    @user = User.new
  end

  def create
    user = User.new(session['user'])
    user.build_address(session['address'])
    if user.save
      customer = Payjp::Customer.create(
        description: 'test',
        card: params[:pay_id]
      )
      card = Card.new(
        pay_id: params[:pay_id],
        customer_id: customer.id,
        user_id: user.id
      )
      card.save
      sign_in(user)
      render 'create'
    end
    # if session['devise.sns_id']
    #   @sns = SnsCredential.find(session['devise.sns_id'])
    #   pass = Devise.friendly_token[0, 20]
    #   params[:user][:password] = pass
    #   params[:user][:password_confirmation] = pass
    #   super
    #   @sns.update(user_id: @user.id)
    # else
    #   super
    # end
  end

  def validation_profile
    user = User.new(profile_params)
    user.phone_number = '0123456789'
    if user.valid?
      user.phone_number = nil
      session['user'] = profile_params
    else
      @user = User.new
      render :profile
    end
  end

  def validation_phone
    user = User.new(session['user'])
    user.phone_number = params[:user][:phone_number]
    if user.valid?
      session['user']['phone_number'] = params[:user][:phone_number]
    else
      @user = User.new
      render :phone
    end
  end

  def validation_address
    user = User.new(session['user'])
    user.build_address(address_params)
    if user.valid?
      session['address'] = address_params
    else
      @user = User.new
      render :address
    end
  end




  
  private
  def profile_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana).merge(birthday: birthday_params)
  end

  def birthday_params
    birthday = params[:birthday]['birthday(1i)'] + '-' + params[:birthday]['birthday(2i)'] + '-' + params[:birthday]['birthday(3i)']
  end

  def address_params
    params.require(:user).require(:address_attributes).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building)
  end
  
  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
