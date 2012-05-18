class ProductInfo
  
  attr_accessor :id, :price, :name, :quantity
  
  def initialize(params)
    @id       = params[:id]
    @name     = params[:name]
    @price    = params[:price]
    @quantity = params[:quantity]
  end
  
end