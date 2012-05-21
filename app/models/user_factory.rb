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
  
  # private
  
  # def build_new_user(item)
    # (:cpf                 => item[:cpf],
             # :nome                => item[:nome],
             # :dataNascimento      => item[:data_nascimento],
             # :dataCadastro        => item[:data_cadastro],
             # :rg                  => item[:rg],
             # :cep                 => item[:cep],
             # :numeroEndereco      => item[:numero_endereco],
             # :complementoEndereco => item[:complemento_endereco],
             # :potencialCompra     => item[:potencial_compra],
             # :email               => item[:email])
  # end
  
  class << self
    
    private
    
    def default_wsdl
      "http://localhost:8280/clientesWS/clientes2?wsdl"
    end
  
  end

  
end