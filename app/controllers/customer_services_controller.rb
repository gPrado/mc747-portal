# encoding: utf-8
class CustomerServicesController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    # @customer_services = CustomerServiceFactory.instance.find_all_by_user_id @current_user.cpf
    @customer_services = [ CustomerService.new(:id => 123, :descricao => "blabla", :tipo => 3, :date => Time.now) ]
  end

  def show
    # @customer_service = CustomerServiceFactory.instance.find(params[:id])
    @customer_service = CustomerService.new(:id => 123, :descricao => "blabla", :tipo => 3, :date => Time.now, :status => 3)
  end

  def new
  end

  def edit
    @customer_service = CustomerService.new(:id => 123, :descricao => "blabla", :tipo => 3)
    # @customer_service = CustomerServiceFactory.instance.find(params[:id])
  end

  def create
    @customer_service = CustomerService.new(params)
    if CustomerServiceFactory.instance.create(@customer_service)
      flash[:notice] = "Sua mensagem foi enviada com sucesso"
      render :index
    else
      flash[:alert] = "Não foi possível efetuar a solicitação"
      render :edit
    end
  end

  def update
    @customer_service = CustomerService.new(params)
    if CustomerServiceFactory.instance.update(@customer_service)
      flash[:notice] = "Sua mensagem foi atualizada com sucesso"
      render :index
    else
      flash[:alert] = "Não foi possível atualizar a solicitação"
      render :edit
    end
  end

end
