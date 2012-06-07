# encoding: utf-8
class Payment

  attr_accessor :cc_numero, :cc_nome, :cc_validade, :cc_codigo, :cc_bandeira,
                :payment_count, :payment_type, :payment_id, :payment_price,
                :agency, :account

  def initialize(params)
    @payment_price = params[:payment_price]
    @payment_count = params[:payment_count]
    @payment_type  = params[:payment_type]
    @payment_id    = params[:payment_id]
    @cc_numero     = params[:cc_numero]
    @cc_nome       = params[:cc_nome]
    @cc_validade   = params[:cc_validade]
    @cc_codigo     = params[:cc_codigo]
    @cc_bandeira   = params[:cc_bandeira]
    @agency   = params[:agency]
    @account   = params[:account]
  end

  def commit?
    payment_type.to_s == "credit_card" || bank_payment.commit?
  end

  def submit
    if payment_type.to_s == "credit_card"
      payment = CreditCardPaymentFactory.instance.make_payment(credit_card, payment_price, payment_count)
      if payment.valid
        :ok
      else
        raise payment.error
      end
    else
      payment_id = bank_payment.make_payment(payment_price)
    end
  end

  def bank_payment
    BankPayment.new(:payment_id   => payment_id,
                    :payment_type => payment_type,
                    :agency       => agency,
                    :account      => account)
  end

  def credit_card
    CreditCard.new(:numero   => cc_numero,
                   :nome     => cc_nome,
                   :validade => cc_validade,
                   :codigo   => cc_codigo,
                   :bandeira => cc_bandeira)
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
