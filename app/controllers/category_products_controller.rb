class CategoryProductsController < ApplicationController
  
  layout 'navigation'
  
  def index
    @title = CategoryFactory.instance.find(params[:category_id].to_i).nome
    @products = ProductFactory.instance.find_all_by_category(params[:category_id].to_i)
    
    if @products.empty?
     flash[:notice] = "Nenhum produto encontrado para a categoria \"#{@title}\""
     redirect_to :back
    else
      @categories = CategoryFactory.instance.all
      @hide_category = true
      render 'products/index'
    end
  end
end