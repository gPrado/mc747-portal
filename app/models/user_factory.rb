class UserFactory < SoapBase

  def find(cpf)
    Rails.logger.debug "#{self.class}#find"
    begin
      response = client.request :mns1, :busca_informacoes_cliente do
        soap.body = {
          "CPF" => cpf
        }
      end
    rescue Savon::SOAP::Fault => e
      Rails.logger.info e.message
      raise e.message
    end

    item = response[:busca_informacoes_cliente_response][:return]
    User.new(item)
  end

  class << self

    private

    def default_wsdl
      "http://localhost:8280/clientesWS/clientes2?wsdl"
    end

  end

end
