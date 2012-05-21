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
    cod_rastr = DeliveryFactory.instance.make_delivery(purchase)
  end

  def status
    DeliveryFactory.instance.status(cod_rastr)
  end

  def human_status
    self.class.human_statuses[status.to_i]
  end

  def allow_delivery
    DeliveryFactory.instance.update_status(cod_rastr, 1)
  end

  def deliver
    DeliveryFactory.instance.update_status(cod_rastr, 3)
  end

  class << self
    
    def human_modo_entregas
      [ "Transporte Aéreo",
        "Transporte Rodoviário",
        "Transp. Rodoviário Prioritário"]
    end
    
    def human_statuses
      [ "Em processamento",
        "Em trânsito",
        "Atrasado",
        "Entregue",
        "Cancelado"]    
    end
    
  end

end