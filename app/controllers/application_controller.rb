class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def authenticate_user!
    if session[:user_id] = 1
      @user_id = session[:user_id]
    else
      redirect_to new_login_path
    end
  end
  
end
