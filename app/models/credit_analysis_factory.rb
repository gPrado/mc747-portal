class CreditAnalysisFactory < SoapBase
  
  def client_status(cpf)
    response = client.request :consulta_cpf do
      soap.body = {
        "CPF" => cpf
      }
    end
    situation = case response[:consulta_cpf_response][:consulta_cpf_result][:codigo_retorno].to_i
    when 0
      :regular
    when 1
      :irregular
    when 2
      :not_found
    else
      :unknown
    end
    CreditAnalysis.new(:situation => situation)
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://mc747grupo04.heliohost.org/ProtecaoAoCredito.asmx?WSDL"
    end
    
  end
  
end
