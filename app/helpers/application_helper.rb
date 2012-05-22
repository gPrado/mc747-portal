module ApplicationHelper
  
  def format_price(price)
    number_to_currency price, :unit => "R$", :separator => ",", :delimiter => "."
  end
  
  def format_date(date)
    l(date, :format => "%d de %B de %Y")
  end
  
end
