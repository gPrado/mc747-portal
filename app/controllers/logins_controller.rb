# encoding: utf-8
class LoginsController < ApplicationController
  
  skip_filter :current_user, :only => :destroy
  
  def new
  end
  
  def create
    if LoginFactory.instance.login(params[:cpf], params[:passwd])
      session[:user_id] = params[:cpf]
      flash[:notice] = "Login realizado com sucesso"
      redirect_to :root
    else
      flash[:alert] = "Usuário não encontrado"
      redirect_to new_login_path
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = "Logout realizado com sucesso"
    redirect_to :root
  end
  
end