class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # methods defined here will be available to all controllers
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  helper_method :current_user

  def sign_in(user)
    session[:user_id] = user.id
  end
  #if we need methods to be available in the view files we will need to add 'helper_method' and the first argument is the method name as a symbol
end
