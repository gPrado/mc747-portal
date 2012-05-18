class UserFactory < SoapBase
  
  def find(cpf)
    response = client.request :busca_informacoes_cliente do
      soap.body = {
        :cpf => cpf
      }
    end
    
    item = response[:exibe_detalhes_id_response][:return][:item]
    item response[:busca_informacoes_cliente_response][:return][:item]
    build_new_user(item)

  end
  
  private
  
  def build_new_user(item)
    # User.new(:cpf                 => 
             # :nome                => 
             # :dataNascimento      => 
             # :dataCadastro        => 
             # :rg                  => 
             # :cep                 => 
             # :numeroEndereco      => 
             # :complementoEndereco => 
             # :potencialCompra     => 
             # :email               => )
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://localhost:8280/clientesWS/clientes2?wsdl"
    end
  
  end

  
end