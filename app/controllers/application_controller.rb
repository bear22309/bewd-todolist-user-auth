class ApplicationController < ActionController::Base
  helper_method :current_user # Makes current_user available in views

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

