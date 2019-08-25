class ApplicationController < ActionController::Base
  # Makes available to our views
  helper_method :current_user, :logged_in?

  def current_user
    # memoization, returned @current_user if it's already defined
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
    #   Note that I am using the method!! not the @current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
