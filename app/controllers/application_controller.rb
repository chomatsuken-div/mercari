class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    user = ENV['BASIC_AUTH_USER']
    pass = ENV['BASIC_AUTH_PASSWORD']
    authenticate_or_request_with_http_basic do |username, password|
      username == user && password == pass
    end
  end
end