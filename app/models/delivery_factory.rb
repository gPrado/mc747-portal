# encoding: utf-8
class DeliveryFactory < SoapBase
  
  def shipping(purchase)
    volume = purchase.volume / 1000000 #convert cm^3 to m^3
    cep = purchase.cep.gsub('-','')
    begin
      10*purchase.modo_entrega
      # response = client.request :calcula_frete do
        # soap.body = {
          # :peso => purchase.weight,
          # :volume => volume,
          # :cep => cep,
          # :modo_entrega => purchase.modo_entrega
        # }
      # end
    rescue Timeout::Error => e
      Rails.logger.info e
      15.0
    end
  end
  
  def make_delivery(purchase)
    "codigo_#{purchase.id}"
  end
  
  def status(cod_rastr)
    "Em preparação"
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://localhost:8680/c06/services/C06_Logistica?wsdl"
    end
    
  end
  
end