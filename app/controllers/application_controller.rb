# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  private
  
  def authenticate_user!
    if session[:user_id]
      @user_id = session[:user_id]
    else
      flash[:notice] = "Você precisa estar autenticado para visualizar essa página"
      redirect_to new_login_path
    end
  end
  
  def user_authenticated?
    !!session[:user_id]
  end
  
  def current_user
    @user_id = session[:user_id]
  end
  
end
