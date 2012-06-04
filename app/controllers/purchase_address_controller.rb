# encoding: utf-8
class PurchaseAddressController < ApplicationController

  before_filter :authenticate_user!

  def edit
    @purchase = Purchase.find(params[:purchase_id])
    @address = @purchase.address
  end

  def update
    @address = Address.new(params)
    @purchase = Purchase.find(params[:purchase_id])

    case params[:button]
    when 'verify_address'
      errors = AddressFactory.instance.verify_address(@address)
      if errors.blank? && !params[:numero].blank?
        @purchase.update_address(@address)
        redirect_to edit_purchase_delivery_path(@purchase)
      else
        if params[:numero].blank?
          errors.concat(", ") unless errors.blank?
          errors.concat("Número deve ser preenchido")
        end
        flash.now[:alert] =  errors
        render :edit
      end
    when 'cep_address'
      begin
        @address = AddressFactory.instance.cep_address(params[:cep])
      rescue Exception => e
        Rails.logger.error e.message
        flash.now[:alert] = e.message
      end
      render :edit
    when 'search_address'
      begin
        @addresses = AddressFactory.instance.search_address(@address)
        if @addresses.empty?
          flash.now[:alert] = "Nenhum resultado encontrado"
          render :edit
        elsif @addresses.size == 1
          @address = @addresses.first
          render :edit
        else
          render :index
        end
      rescue Exception => e
        Rails.logger.error e.message
        flash.now[:alert] = e.message
        render :edit
      end
    else
      raise "Unknown Value"
    end
  end

end