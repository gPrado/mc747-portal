class BankPaymentFactory < SoapBase
  
  def boleto(account, agency, price)
    Rails.logger.debug "#{self.class}#boleto"
    return (rand*1000).to_i #TODO remove this line when wsdl if implemented
    response = client.request :pagar_via_boleto_bancario do
      soap.body = {
        :agencia => agency,
        :conta   => account,
        :valor   => price
      }
    end
    
    response[:pagar_via_boleto_bancario_response][:pagar_via_boleto_bancario_return]
  end
  
  def transferencia(account, agency, price)
    Rails.logger.debug "#{self.class}#transferencia"
    return (rand*1000).to_i #TODO remove this line when wsdl if implemented
    response = client.request :pagar_via_transferencia_bancaria do
      soap.body = {
        :agencia => agency,
        :conta   => account,
        :valor   => price
      }
    end
    
    response[:pagar_via_transferencia_bancaria_response][:pagar_via_transferencia_bancaria_return]
  end
  
  def deposito(account, agency, price)
    Rails.logger.debug "#{self.class}#deposito"
    return (rand*1000).to_i #TODO remove this line when wsdl if implemented
    response = client.request :pagar_via_deposito_bancario do
      soap.body = {
        :agencia => agency,
        :conta   => account,
        :valor   => price
      }
    end
    
    response[:pagar_via_deposito_bancario_response][:pagar_via_deposito_bancario_return]
  end
  
  def status(id)
    Rails.logger.debug "#{self.class}#status"
    return "pendente" #TODO remove this line when wsdl if implemented
    response = client.request :verifica_status_pagamento do
      soap.body = {
        :id_pagamento => id
      }
    end
    
    response[:verifica_status_pagamento_response][:verifica_status_pagamento_return]
  end
  
  class << self
    
    private
    
    def default_wsdl
      ""
    end
    
  end
  
end
