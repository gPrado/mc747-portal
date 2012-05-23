# encoding: utf-8
class CustomerServicesController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @customer_services = CustomerServiceFactory.instance.find_all_by_user_id @current_user.cpf
  end

  def show
    @customer_service = CustomerServiceFactory.instance.find(params[:id])
  end

  def new
  end

  def edit
    @customer_service = CustomerServiceFactory.instance.find(params[:id])
  end

  def create
    @customer_service = CustomerService.new(params)
    Rails.logger.debug  @customer_service = CustomerService.new(params.merge({:user_id => @current_user.cpf}))
    if CustomerServiceFactory.instance.create(@customer_service)
      flash[:notice] = "Sua mensagem foi enviada com sucesso"
      redirect_to customer_services_path
    else
      flash.now[:alert] = "Não foi possível efetuar a solicitação"
      render :edit
    end
  end

  def update
    @customer_service = CustomerService.new(params.merge({:user_id => @current_user.cpf}))
    if CustomerServiceFactory.instance.update(@customer_service)
      flash[:notice] = "Sua mensagem foi atualizada com sucesso"
      redirect_to customer_services_path
    else
      flash.now[:alert] = "Não foi possível atualizar a solicitação"
      render :edit
    end
  end

end
