# encoding: utf-8
class Payment
  
  attr_accessor :cc_numero, :cc_nome, :cc_validade, :cc_codigo, :cc_bandeira,
                :payment_count, :payment_type, :payment_id, :price
  
  def initialize(params)
    @price         = params[:price],
    @payment_count = params[:payment_count],
    @payment_type  = params[:payment_type],
    @payment_id    = params[:payment_id],
    @cc_numero     = params[:cc_numero],
    @cc_nome       = params[:cc_nome],
    @cc_validade   = params[:cc_validade],
    @cc_codigo     = params[:cc_codigo],
    @cc_bandeira   = params[:cc_bandeira]
  end
  
  def submit
    if payment_type.to_s == "credit_card"
      payment = CreditCardPaymentFactory.instance.make_payment(credit_card, price, payment_count)
      if payment.valid
        :ok
      else
        raise payment.error
      end
    else
      payment_id = bank_payment.make_payment(price)
    end
  end
  
  def bank_payment
    BankPayment.new(:payment_id   => payment_id,
                    :payment_type => payment_type)
  end
  
  def credit_card
    CreditCard.new(:cc_numero   => cc_numero,
                   :cc_nome     => cc_nome,
                   :cc_validade => cc_validade,
                   :cc_codigo   => cc_codigo,
                   :cc_bandeira => cc_bandeira)
  end
  
  def human_payment_type
    self.class.human_payment_type payment_type
  end
  
  class << self

    def human_payment_type(payment_type)
      case payment_type
      when "boleto"
        "Boleto Bancário"
      when "transferencia"
        "Transferência Bancária"
      when "deposito"
        "Depósito Bancário"
      when "credit_card"
        "Cartão de Crédito"
      else
        raise "Unknown payment type"
      end
    end
    
    def payment_types
      ["boleto" ,"transferencia", "deposito", "credit_card"].map do |type|
        [human_payment_type(type), type]
      end
    end
  end
end
