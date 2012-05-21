class Purchase < ActiveRecord::Base
  
  attr_accessible :id, :user_id, :completed,
                  :cep, :logradouro, :bairro, :localidade, :uf, :complemento, :numero,
                  :modo_entrega, :shipping, :estimated_time,
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

  def products_price_juros
    products_price*(1+juros)
  end

  def juros
    case payment_type
    when "credit_card"
      credit_card.juros[payment_count-1]
    else
      0
    end
  end

  def price
    products_price_juros + shipping
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

  def update_cc(cc)
    update_attributes!(:cc_numero   => cc.numero,
                       :cc_nome     => cc.nome,
                       :cc_bandeira => cc.bandeira,
                       :cc_codigo   => cc.codigo,
                       :cc_validade => cc.validade)
  end

  def update_payment_type(payment_type)
    update_attributes!(:payment_type => payment_type)
  end

  def update_payment_count(payment_count)
    update_attributes!(:payment_count => payment_count)
  end

  def shipping
    @shipping || delivery.shipping.fee
  end

  def estimated_time
    @estimated_time || delivery.shipping.estimated_time
  end

  def delivery_status
    delivery.human_status
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

  def credit_card
    CreditCard.new(:numero   => cc_numero,
                   :nome     => cc_nome,
                   :validade => cc_validade,
                   :codigo   => cc_codigo,
                   :bandeira => cc_bandeira)
  end

  def submit
    pps = ProductPurchase.find_all_by_purchase_id(id)
    pps.empty? and return false
    if payment_id = payment.submit
      cod_rastr = delivery.submit
      products.each{ |p| p.submit }
      update_attribute :completed, true
      update_attribute :shipping, shipping
      update_attribute :estimated_time, estimated_time
      update_attribute :cod_rastr, cod_rastr
      update_attribute :payment_id, payment_id
      
      delivery.allow_delivery if payment_type.to_s == "credit_card"
    end
    true
  end

  class << self
    
    def edit_or_new(user_id)
      find_cart(user_id) || create_for_user(user_id)
    end
    
    def create_for_user(user_id)
      transaction do
        cart = create(:user_id => user_id.to_s)
        cart.update_address(Address.from_user(user_id))
      end
      find_cart(user_id)
    end
    
    def find_cart(user_id)
      where(:user_id => user_id.to_s, :completed => false).first
    end
    
  end

end
  