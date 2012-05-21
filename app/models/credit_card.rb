# encoding: utf-8
class CreditCard
  
  attr_accessor :nome, :bandeira, :numero, :validade, :codigo
  
  delegate :available_payment_count, :juros, :to => :type
  
  def initialize(params = {})
    @nome     = params[:nome]
    @bandeira = params[:bandeira]
    @numero   = params[:numero]
    @validade = params[:validade]
    @codigo   = params[:codigo]
  end
  
  def type
    self.class.of_type(bandeira)
  end
  
  class << self
    
    def available_bandeiras
      all_cards.map &:bandeira
    end
    
    def all_cards
      @all_cards ||= CreditCardPaymentFactory.instance.card_list
    end
    
    def of_type(bandeira)
      all_cards.find{ |c| c.bandeira == bandeira }
    end
    
  end
  
  class CreditCardType
    
    attr_accessor :bandeira, :qtd_max_parcelas, :juros
    
    def initialize(params)
      @bandeira         = params[:bandeira]
      @qtd_max_parcelas = params[:qtd_max_parcelas].to_i
      @juros            = params[:juros].map &:to_f
    end
    
    def available_payment_count(purchase_power)
      base_count = qtd_max_parcelas
      max = case purchase_power
      when "baixo"
        1
      when "medio"
        [(0.5 * base_count).to_i, 1].max
      when "alto"
        [(0.8 * base_count).to_i, 1].max
      when "muitoAlto"
        base_count
      else
        raise "Unknown purchase power"
      end
      human_payment_count = [ " 1 Parcela (sem juros)" ]
      juros[1..max-1].each_with_index do |j, i|
        human_payment_count << " #{i+2} Parcelas (#{j*100}% juros)"
      end
      human_payment_count.zip(1..max)
    end
    
  end
  
end
