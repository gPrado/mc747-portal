class ProductInfoFactory < SoapBase
  
  def find(id)
    response = client.request :return_product_info do
      soap.body = {
        "ID" => id
      }
    end
    build_product_info(response[:return_product_info_response][:return_product_info_result])
  rescue Savon::SOAP::Fault => e
    Rails.logger.info e
    build_product_info(:id => id, :price => 100.0, :quantity => 10, :name => "Stub")
  end
  
  private
  
  def build_product_info(item)
    ProductInfo.new(:id       => item[:id].to_s,
                    :price    => item[:price].to_f,
                    :quantity => item[:quantity].to_i,
                    :name     => item[:name].to_s)
  end
  
  class << self
    
    private
    
    def default_wsdl
      # "http://controlaestoque.heliohost.org/Service1.asmx?wsdl=0" #stubs
      "http://gerestoque.heliohost.org/Service1.asmx?wsdl" #production
    end
    
  end
  
end