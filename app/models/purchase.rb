class Purchase < ActiveRecord::Base
  
  attr_accessible :id, :user_id, :completed,
                  :cep, :logradouro, :bairro, :localidade, :uf, :complemento, :numero
  
  def user
    @user ||= User.find(user_id)
  end

  def products
    ProductPurchase.find_all_by_purchase_id(id)
  end

  def update_product(product_id, product_amount = 0)
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pp = pps.find{ |pp| pp.product_id == product_id }
    if pp
      pp.product_amount = product_amount > 0 ? product_amount : pp.product_amount + 1
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

  def update_address(address)
    update_attributes!(:cep         => address.cep,
                       :logradouro  => address.logradouro,
                       :bairro      => address.bairro,
                       :localidade  => address.localidade,
                       :uf          => address.uf,
                       :numero      => address.numero,
                       :complemento => address.complemento)
  end

  def address
    Address.new(:cep         => cep,
                :logradouro  => logradouro,
                :bairro      => bairro,
                :localidade  => localidade,
                :uf          => uf,
                :numero      => numero,
                :complemento => complemento)
  end

  class << self
    
    def edit_or_new(user_id)
      where(:user_id => user_id.to_s, :completed => false).first || create(:user_id => user_id.to_s)
    end
    
  end

end
  