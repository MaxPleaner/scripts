class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user

  private

  # Function that requires a current user to be logged in (i.e. have a session stored) before accessing any portion of the app
  # By default, every action requires login - however, exceptions are specified in the appropriate controllers. e.g. do not want to require login
  # before signing up
  def require_login
  	unless current_user
  		flash[:error] = "You must be logged in to access this section"
  		redirect_to log_in_path
  	end
  end

  private

  # Function to return current logged in user based on user_id stored in session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end


end

