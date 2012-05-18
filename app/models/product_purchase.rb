class ProductPurchase < ActiveRecord::Base
  
  attr_accessible :purchase_id, :product_id, :product_amount
  
  delegate :nome, :to => :product
    
  def product
    @product ||= ProductFactory.instance.find(product_id)
  end
  
  def price
    product_amount * product.price
  end
  
end
