module ApplicationHelper
  
  def format_price(price)
    number_to_currency price, :unit => "R$", :separator => ",", :delimiter => "."
  end
  
end
