class ProductPurchase < ActiveRecord::Base
  
  attr_accessible :purchase_id, :product_id, :product_amount,
                  :product_price
  
  delegate :nome, :to => :product
    
  def product
    @product ||= ProductFactory.instance.find(product_id)
  end
  
  def price
    product_amount * product_price
  end
  
  def product_price
    @product_price || product.price
  end
  
  def volume
    product_amount * product.volume
  end
  
  def weight
    product_amount * product.peso
  end
  
  def submit
    update_attribute(:product_price, product.price)
  end
  
end
