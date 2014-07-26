class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def yo_confirmed_user!
    redirect_to holding_path unless current_user.yo_confirmed?
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end
end
