class UserFactory < SoapBase
  
  def find(cpf)
    # response = client.request :busca_informacoes_cliente do
      # soap.body = {
        # "CPF" => cpf
      # }
    # end
#     
    # item response[:busca_informacoes_cliente_response][:return][:item]
    # User.new(item)
    User.new(:nome => "Gabriel", :cpf => "123", :cep => "13073-010", :numero_endereco => "101", :complemento_endereco => "apto 1042") #TODO remove this line
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