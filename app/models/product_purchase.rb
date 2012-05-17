class ProductPurchase < ActiveRecord::Base
  
  attr_accessible :purchase_id, :product_id, :product_amount
    
  def product
    @product ||= ProductFactory.instance.find(product_id)
  end
  
end
