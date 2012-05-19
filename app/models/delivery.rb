# encoding: utf-8
class Delivery
  attr_accessor :cod_rastr, :modo_entrega, :purchase
  
  def initialize(params)
    @purchase     = params[:purchase]
    @modo_entrega = params[:modo_entrega]
    @cod_rastr    = params[:cod_rastr]
  end

  def human_modo_entrega
    self.class.human_modo_entregas[modo_entrega - 1]
  end

  def shipping
    DeliveryFactory.instance.shipping(purchase)
  end

  def submit
    @cod_rastr = DeliveryFactory.instance.make_delivery(purchase)
  end

  def status
    DeliveryFactory.instance.status(cod_rastr)
  end

  class << self
    
    def human_modo_entregas
      [ "Transporte Aéreo",
        "Transporte Rodoviário",
        "Transp. Rodoviário Prioritário"]
    end
    
  end

end