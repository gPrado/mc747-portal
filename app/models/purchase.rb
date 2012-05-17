class Purchase < ActiveRecord::Base
  
  attr_accessible :id, :user_id, :completed
  
  def user
    @user ||= User.find(user_id)
  end

  def products
    pps = ProductPurchase.find_all_by_purchase_id(id)
    @products ||= pps.map do |pp|
      { :product => pp.product,
        :amount => pp.product_amount }
    end
  end

  def update_product(product_id, amount = 0)
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pp = pps.find{ |pp| pp.product_id == product_id }
    if pp
      pp.product_amount = amount > 0 ? amount : pp.product_amount + 1
      pp.save
    else
      ProductPurchase.create :product_id => product_id, :purchase_id => id
    end
  end

  def delete_product(product_id)
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pp = pps.find{ |pp| pp.product_id == product_id }
    pp.delete if pp
  end

  def submit
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pps.empty? and return false
    update_attribute :completed, true
  end

  class << self
    
    def edit_or_new(user_id)
      where(:user_id => user_id.to_s, :completed => false).first || create(:user_id => user_id.to_s)
    end
    
  end

end
  