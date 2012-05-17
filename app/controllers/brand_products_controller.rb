class BrandProductsController < ApplicationController
  
  layout 'navigation'
  
  def index
    @products = ProductFactory.instance.find_all_by_brand(params[:brand_id].to_i)
    
    if @products.empty?
     flash[:notice] = "Nenhum produto encontrado para a marca selecionada \"#{@title}\""
     redirect_to :back
    else
      @categories = CategoryFactory.instance.all
      @title = @products.first.marca_nome
      @hide_brand = true
      render 'products/index'
    end
  end
end