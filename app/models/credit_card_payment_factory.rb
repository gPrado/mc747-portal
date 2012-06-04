# encoding: utf-8
class CreditCardPaymentFactory < SoapBase

  def make_payment(credit_card, price, payment_count)
    price *= 100 #convert to centavos
    Rails.logger.debug "#{self.class}#make_payment"
    response = client.request :valida_compra, :valida_compra do
      soap.body = {
        "ValorDaCompra"        => price.ceil,
        "NomeDoTitular"        => credit_card.nome,
        "BandeiraDoCartao"     => credit_card.bandeira,
        "NumeroDoCartao"       => credit_card.numero,
        "DataDeValidade"       => credit_card.validade,
        "CodigoDeSeguranca"    => credit_card.codigo,
        "QuantidadeDeParcelas" => payment_count
      }
    end
    CreditCardPayment.new(:valid => response[:valida_compra_response][:return])
  rescue Savon::SOAP::Fault => e
    Rails.logger.info e.message
    msg = response && response[:fault] && response[:fault][:faultstring]
    msg = e.message if msg.blank?
    CreditCardPayment.new(:valid => false, :error => msg)
  end

  def card_list
    Rails.logger.debug "#{self.class}#card_list"
    response = client.request :lista_cartoes, :lista_cartoes
    response[:lista_cartoes_response][:return].map do |item|
      build_card(item)
    end
  end

  def reset
    Rails.logger.debug "#{self.class}#reset"
    client.request :reset, :reset
  end

  private

  def build_card(item)
    juros = if(item[:juros].is_a?(Array))
              item[:juros].map { |j| j[:juros] }
            else
              [item[:juros][:juros]]
            end
    CreditCard::CreditCardType.new(:bandeira         => item[:bandeira],
                                   :qtd_max_parcelas => item[:quantidade_max_parcelas],
                                   :juros            => juros)
  end

  class << self

    private

    def default_wsdl
      "http://ec2-50-19-145-76.compute-1.amazonaws.com:8080/PagamentoCartao/PagamentoCartao?wsdl"
    end

  end

end
