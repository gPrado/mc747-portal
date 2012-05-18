class LoginFactory < SoapBase
  
  def login(cpf, passwd)
    response = client.request :authenticate do
      soap.body = {
        :cpf      => cpf,
        :password => passwd
      }
    end
      
    response[:authenticate_response][:return] != "Invalid user/password"
    true #TODO remove this line
  end
    
  class << self
    
    private
    
    def default_wsdl
      "http://sci-psych.com/mc747/AuthService/public/index/wsdl"
    end
  
  end
  
end