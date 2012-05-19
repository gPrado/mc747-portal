class BankPayment
  
  attr_accessor :payment_id, :payment_type
  
  def initialize(params)
    @payment_id   = params[:payment_id]
    @payment_type = params[:payment_type]
  end
  
  def make_payment(price)
    account = portal_account_info.account
    agency = portal_account_info.agency
    
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
  end
  
  def status
    BankPaymentFactory.instance.status(payment_id)
  end
  
  private
  
  def portal_account_info
    PortalAccountInfo.instance
  end
end
