class PurchasePaymentController < ApplicationController
  
  before_filter :authenticate_user!
  
  def edit
    @purchase = Purchase.find(params[:purchase_id])
  end
  
  def update
    @purchase = Purchase.find(params[:purchase_id])
    @purchase.update_payment_type(params[:payment_type])
    if params[:payment_type] == "credit_card"
      redirect_to edit_cc_purchase_payment_path(@purchase)
    else
      redirect_to purchase_payment_path(@purchase)
    end
  end
    
  def edit_cc
    @purchase = Purchase.find(params[:purchase_id])
  end
  
  def update_cc
    @purchase = Purchase.find(params[:purchase_id])
    @purchase.update_cc(CreditCard.new(params))
    redirect_to edit_payment_count_purchase_payment_path(@purchase)
  end
  
  def edit_payment_count
    @purchase = Purchase.find(params[:purchase_id])
  end
  
  def update_payment_count
    @purchase = Purchase.find(params[:purchase_id])
    begin
      @purchase.update_payment_count(params[:payment_count])
    rescue Exception => e
      flash[:alert] = e.message
    end
    redirect_to edit_payment_count_purchase_payment_path(@purchase)
  end
  
  def show
    @purchase = Purchase.find(params[:purchase_id])
  end
  
end