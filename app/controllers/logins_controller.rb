# encoding: utf-8
class LoginsController < ApplicationController
  
  def new
  end
  
  def create
    if user = LoginFactory.instance.login(params[:cpf], params[:passwd])
      session[:user_id] = user.id
    else
      flash[:alert] = "Usuário não encontrado"
      redirect_to new_login_path
    end
  end
  
end