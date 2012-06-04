# encoding: utf-8
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

  def index
    @query = params[:q]
    if @query && !@query.empty?
      @products = ProductFactory.instance.search(@query)

      if @products.empty?
       flash[:notice] = "Nenhum produto encontrado para a busca por \"#{@query}\""
       redirect_to :root
      else
        @categories = CategoryFactory.instance.all
        @title = "Resultados da busca por \"#{@query}\""
      end
    else
      flash[:alert] = "Busca não pode ser vazia"
      redirect_to :root
    end
  end

end
