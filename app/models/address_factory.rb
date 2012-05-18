class AddressFactory < SoapBase
  
  def verify_address(address)
    response = client.request :verify_address do
      soap.body = {
        :address => {
          :cep        => address.cep,
          :logradouro => address.logradouro,
          :bairro     => address.bairro,
          :localidade => address.localidade,
          :uf         => address.uf
        }
      }
    end
    errors = response[:verify_address_response][:return][:errors][:item]
    if errors 
      if errors.instance_of?(Array)
        errors.map{ |item| item[:description] }.join(", ")
      else
        errors[:description]
      end
    else
      ""
    end
  end
  
  def search_address(address)
    response = client.request :search_address do
      soap.body = {
        :query => "#{address.cep} #{address.logradouro} #{address.bairro} #{address.localidade} #{address.uf}"
      }
    end
    
    errors = response[:search_address_response][:return][:errors][:item]
    
    if(errors)
      raise errors[:description]
    else
      response[:search_address_response][:return][:addresses][:item].map do |item|
        Address.new(item)
      end
    end
  end
  
  def cep_address(cep)
    response = client.request :cep_address do
      soap.body = {
        :cep => cep
      }
    end
    
    errors = response[:cep_address_response][:return][:errors][:item]
    
    if(errors)
      raise errors[:description]
    else
      Address.new(response[:cep_address_response][:return][:address])
    end
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://localhost:8888/address_services/wsdl"
      #"http://padovan.org:3000/address_services/wsdl"
    end
  
  end
  
end