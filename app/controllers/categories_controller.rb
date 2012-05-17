class CategoriesController < ApplicationController
  
  def index
    @categories = CategoryFactory.instance.all
  end
end