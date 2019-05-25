class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook) #コールバック
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    if user_signed_in?
      redirect_to root_path
    end

    sns_info = SnsCredential.from_omniauth(
      request.env['omniauth.auth'].except(:extra)
    )
    @user = sns_info[:user]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.sns_id'] = sns_info[:sns_id]
      render template: 'devise/registrations/new'
    end

  end

  def failure
    redirect_to root_path and return
  end
end