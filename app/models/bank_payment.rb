# encoding: utf-8
class BankPayment

  attr_accessor :payment_id, :payment_type, :agency, :account

  def initialize(params)
    @payment_id   = params[:payment_id]
    @payment_type = params[:payment_type]
    @agency   = params[:agency]
    @account = params[:account]
  end

  def make_payment(price)
    payment_id = case payment_type.to_s
    when "boleto"
      BankPaymentFactory.instance.boleto(account, agency, price)
    when "transferencia"
      BankPaymentFactory.instance.transferencia(account, agency, price)
    when "deposito"
      BankPaymentFactory.instance.deposito(account, agency, price)
    else
      raise "Unknown payment type"
    end

    if payment_id.to_i < 0
      raise "Agência/Conta inválidas"
    end
    payment_id
  end

  def status
    self.class.human_statuses[BankPaymentFactory.instance.status(payment_id)]
  end

  def commit?
    status == "Efetuado"
  end

  private

  def portal_account_info
    PortalAccountInfo.instance
  end

  class << self

    def human_statuses
      {
        'S05_R01' => 'Pendente',
        'S05_R02' => 'Efetuado',
        'S05_E01' => 'Não encontrado'
      }
    end

  end
end
