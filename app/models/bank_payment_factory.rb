class BankPaymentFactory < SoapBase
  
  def boleto(account, agency, price)
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
