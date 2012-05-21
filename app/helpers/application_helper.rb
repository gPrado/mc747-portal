module ApplicationHelper
  
  def format_price(price)
    number_to_currency price, :unit => "R$", :separator => ",", :delimiter => "."
  end
  
  def format_date(date)
    date.strftime("%d %b %Y")
  end
  
end
