# encoding: utf-8
class PurchaseAddressController < ApplicationController
  
  def edit
    @purchase = Purchase.find(params[:purchase_id])
    @address = @purchase.address
  end
  
  def update
    @address = Address.new(params)
    @purchase = Purchase.find(params[:purchase_id])
    errors = AddressFactory.instance.verify_address(@address)
    if errors.blank? && !params[:numero].blank?
      @purchase.update_address(@address)
      redirect_to edit_purchase_payment_path(@purchase)
    else
      errors.concat(", Número deve ser preenchido") if params[:numero].blank?
      flash.now[:alert] =  errors
      render :edit
    end
  end
  
end