# encoding: utf-8
class CreditCardPaymentFactory < SoapBase
  
  def make_payment(credit_card, price, payment_count)
    response = client.request :valida_compra, :valida_compra do
      soap.body = {
        "ValorDaCompra"        => price,
        "NomeDoTitular"        => credit_card.nome,
        "BandeiraDoCartão"     => credit_card.bandeira,
        "NumeroDoCartão"       => credit_card.numero,
        "DataDeValidade"       => credit_card.validade,
        "CodigoDeSeguranca"    => credit_card.codigo,
        "QuantidadeDeParcelas" => payment_count
      }
    end
    CreditCardPayment.new(:valid => response[:valida_compra_response][:return])
  rescue Savon::SOAP::Fault => e
    CreditCardPayment.new(:valid => false, :error => r.to_hash[:fault][:faultstring])
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://ec2-50-19-145-76.compute-1.amazonaws.com:8080/PagamentoCartao/PagamentoCartao?wsdl"
    end
    
  end
  
end