class ProductsController < ApplicationController
  
  layout 'navigation'
  
  def show
    @categories = CategoryFactory.instance.all
    @title = "Nome da Marca"
    @product = ProductFactory.instance.find(params[:id].to_i)
    if !@product
      render :not_found and return
    end
  end
end
