# encoding: utf-8
class CategoryProductsController < ApplicationController
  
  layout 'navigation'
  
  def index
    category = CategoryFactory.instance.find(params[:category_id].to_i)
    if category
      @title = category.nome
      @products = ProductFactory.instance.find_all_by_category(params[:category_id].to_i)
      
      if @products.empty?
       flash[:notice] = "Nenhum produto encontrado para a categoria \"#{@title}\""
       redirect_to :back
      else
        @categories = CategoryFactory.instance.all
        @hide_category = true
        render 'products/index'
      end
    else
      flash[:alert] = "Categoria não encontrada"
      redirect_to :root
    end
  end
end