# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  private
  
  def authenticate_user!
    if user_authenticated?
      current_user
    else
      flash[:notice] = "Você precisa estar autenticado para visualizar essa página"
      redirect_to new_login_path
    end
  end
  
  def user_authenticated?
    !!session[:user_id]
  end
  
  def current_user
    @current_user = UserFactory.instance.find session[:user_id] if user_authenticated?
  end
  
end
