# encoding: utf-8
class ProductInfoFactory < SoapBase

  def find(id)
    Rails.logger.debug "#{self.class}#find"
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

  def add(id, qtd)
    Rails.logger.debug "#{self.class}#add"
    response = client.request :add_product do
      soap.body = {
        "ID"  => id,
        "qtd" => qtd
      }
    end
    return response[:add_product_response][:add_product_result] =~ /sucesso/
  rescue Savon::SOAP::Fault => e
    Rails.logger.info e
    raise "Não foi possível adicionar mais produtos - #{e}"
  end

  def sub(id, qtd)
    Rails.logger.debug "#{self.class}#sub"
    response = client.request :sub_product do
      soap.body = {
        "ID"  => id,
        "qtd" => qtd
      }
    end
    return response[:sub_product_response][:sub_product_result] =~ /sucesso/
  rescue Savon::SOAP::Fault => e
    Rails.logger.info e
    raise "Não foi possível remover produtos - #{e}"
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
