class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end
  include ErrorHandlers

  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def check_signin
    raise "Sign in required." unless current_user
  end
end
