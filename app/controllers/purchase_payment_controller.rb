class PurchasePaymentController < ApplicationController
  
  def edit
    @purchase = Purchase.find(params[:purchase_id])
  end
  
  def update
    @purchase = Purchase.find(params[:purchase_id])
    redirect_to purchase_path(@purchase)
  end
  
end