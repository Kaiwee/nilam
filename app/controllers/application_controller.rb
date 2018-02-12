class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def logged_in?
  	!current_user.nil?
  end
  helper_method :logged_in?

  # clears the session by setting the value of `:user_id` key to `nil`
  def sign_out
  	session[:user_id] = nil
  end 
  helper_method :sign_out
end
