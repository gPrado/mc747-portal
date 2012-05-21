# encoding: utf-8
class DeliveryFactory < SoapBase
  
  def shipping(purchase)
    Rails.logger.debug "#{self.class}#shipping"
    volume = purchase.volume / 1000000 #convert cm^3 to m^3
    cep = purchase.cep.gsub('-','')
    begin
      response = client.request :calcula_frete do
        soap.body = {
          :peso         => purchase.weight.ceil, #TODO weight should accept a double value
          :volume       => volume,
          :cep          => cep,
          :modo_entrega => purchase.modo_entrega
        }
      end
    rescue Timeout::Error => e
      Rails.logger.info e
      return build_shipping([nil, 10*purchase.modo_entrega, 2*purchase.modo_entrega])
    end
    
    item = response[:calcula_frete_response][:calcula_frete_return]
    build_shipping(item)
  end
  
  def make_delivery(purchase)
    Rails.logger.debug "#{self.class}#make_delivery"
    volume = purchase.volume / 1000000 #convert cm^3 to m^3
    cep = purchase.cep.gsub('-','')
    begin
      response = client.request :webservice_transporte do
        soap.body = {
          :peso           => purchase.weight.ceil, #TODO weight should accept a double value
          :volume         => volume,
          :cep            => cep,
          :modo_entrega   => purchase.modo_entrega,
          "id_NotaFiscal" => purchase.id
        }
      end
    rescue Timeout::Error => e
      raise e.message
    end
    
    response[:webservice_transporte_response][:webservice_transporte_return][1]
  end
  
  def status(cod_rastr)
    Rails.logger.debug "#{self.class}#status"
    begin
      response = client.request :check_status do
        soap.body = {
          :cod_rastr => cod_rastr
        }
      end
    rescue Timeout::Error => e
      raise e.message
    end

    response[:check_status_response][:check_status_return][1]
  end
  
  def update_status(cod_rastr, status = 1)
    Rails.logger.debug "#{self.class}#update_status"
    begin
      response = client.request :check_status do
        soap.body = {
          :cod_rastr => cod_rastr,
          :id_status => status
        }
      end
    rescue Timeout::Error => e
      raise e.message
    end

    response[:check_status_response][:check_status_return][4].to_i == 1
  end
  
  private
  
  def build_shipping(item)
    Shipping.new(:fee            => item[1].to_f,
                 :estimated_time => item[2].to_i)
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://localhost:8680/c06/services/C06_Logistica?wsdl"
    end
    
  end
  
end