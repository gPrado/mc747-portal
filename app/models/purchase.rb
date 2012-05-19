class Purchase < ActiveRecord::Base
  
  attr_accessible :id, :user_id, :completed,
                  :cep, :logradouro, :bairro, :localidade, :uf, :complemento, :numero,
                  :modo_entrega, :shipping,
                  :payment_count, :payment_type, :payment_id,
                  :cc_numero, :cc_nome, :cc_validade, :cc_codigo, :cc_bandeira
  
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

  def volume
    products.reduce(0) do |memo, product|
      memo + product.volume
    end
  end

  def weight
    products.reduce(0) do |memo, product|
      memo + product.weight
    end
  end

  def products_price
    products.reduce(0) do |memo, product|
      memo + product.price
    end    
  end

  def price
    products_price + shipping
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

  def update_delivery(delivery)
    update_attributes!(:modo_entrega => delivery.modo_entrega)
  end

  def shipping
    @shipping || delivery.shipping
  end

  def delivery_status
    delivery.status
  end

  def delivery
    Delivery.new(:modo_entrega => modo_entrega,
                 :purchase     => self,
                 :cod_rastr    => cod_rastr)
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

  def payment
    Payment.new(:price         => price,
                :payment_count => payment_count,
                :payment_type  => payment_type,
                :payment_id    => payment_id,
                :cc_numero     => cc_numero,
                :cc_nome       => cc_nome,
                :cc_validade   => cc_validade,
                :cc_codigo     => cc_codigo,
                :cc_bandeira   => cc_bandeira)
  end

  def submit
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pps.empty? and return false
    if payment_id = payment.submit
      products.each{ |p| p.submit }
      cod_rastr = delivery.submit
      update_attribute :completed, true
      update_attribute :shipping, shipping
      update_attribute :cod_rastr, cod_rastr
      update_attribute :payment_id, payment_id
    end
  end

  class << self
    
    def edit_or_new(user_id)
      find_cart(user_id) || create_for_user(user_id)
    end
    
    def create_for_user(user_id)
      transaction do
        address = create(:user_id => user_id.to_s)
        address.update_address(Address.from_user(user_id))
      end
      find_cart(user_id)
    end
    
    def find_cart(user_id)
      where(:user_id => user_id.to_s, :completed => false).first
    end
    
  end

end
  