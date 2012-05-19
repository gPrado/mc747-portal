class CreditCardPayment
  attr_accessor :valid, :error
  
  def initialize(params)
    @valid = params[:valid]
    @error = params[:error] || ""
  end
  
end