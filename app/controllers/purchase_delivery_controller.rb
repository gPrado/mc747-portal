class PurchaseDeliveryController < ApplicationController
  
  before_filter :authenticate_user!
  
  def edit
    @purchase = Purchase.find(params[:purchase_id])
    @delivery = @purchase.delivery
  end
  
  def update
    @purchase = Purchase.find(params[:purchase_id])
    @delivery = Delivery.new(params.merge(:purchase => @purchase))
    @purchase.update_delivery(@delivery)
    render :edit
  end
  
end
