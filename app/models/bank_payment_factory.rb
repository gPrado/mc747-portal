class BankPaymentFactory < SoapBase

  def boleto(account, agency, price)
    Rails.logger.debug "#{self.class}#boleto"
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
      "http://localhost:8180/pagamento_C10_G10/services/PagamentoBanco?wsdl"
    end

  end

end
