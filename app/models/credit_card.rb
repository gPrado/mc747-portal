class CreditCard
  
  attr_accessor :nome, :bandeira, :numero, :validade, :codigo
  
  def initialize(params)
    @nome     = params[:nome] || "Joao"
    @bandeira = params[:bandeira] || "Visa"
    @numero   = params[:numero] || "1234.1234.1234.1234"
    @validade = params[:validade] || "12/12"
    @codigo   = params[:codigo] || "123"
  end
  
end