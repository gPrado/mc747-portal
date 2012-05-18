# encoding: utf-8
class PurchasesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @purchases = Purchase.where(:completed => true).order('updated_at DESC').find_all_by_user_id(@user_id)
  end
  
  def show
    @purchase = Purchase.find(params[:id])
    if @purchase.user_id != @user_id.to_s
      render :forbidden and return
    end
  end
  
  def add_product
    @purchase = Purchase.edit_or_new(@user_id)
    @purchase.update_product(params[:id])
    flash[:notice] = "Produto adicionado ao carrinho com sucesso"
    redirect_to cart_purchases_path
  end
  
  def delete_product
    @purchase = Purchase.edit_or_new(@user_id)
    @purchase.delete_product(params[:id])
    flash[:notice] = "Produto removido do carrinho com sucesso"
    redirect_to cart_purchases_path
  end
  
  def update_product
    @purchase = Purchase.edit_or_new(@user_id)
    @purchase.update_product(params[:id], params[:amount].to_i)
    flash[:notice] = "Quantidade atualizada com sucesso"
    redirect_to cart_purchases_path
  end
  
  def cart
    @purchase = Purchase.edit_or_new(@user_id)
    @cart_products = @purchase.products
  end
  
  def create
    @purchase = Purchase.edit_or_new(@user_id)
    if @purchase.submit
      flash[:notice] = "Compra realizada com sucesso!"
      redirect_to :root
    else
      flash[:alert] = "A compra não pôde ser efetuada"
      redirect_to cart_purchases_path
    end
  end
  
end