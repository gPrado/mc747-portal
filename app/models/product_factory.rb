class ProductFactory < SoapBase
  
  def find_all_by_category(category_id)
    Rails.logger.debug "#{self.class}#find_all_by_category"
    response = client.request :busca_avancada do
      soap.body = {
        :categoria_id => category_id,
        :marca => nil
      }
    end
    
    array = response[:busca_avancada_response][:return][:item] || []
    array.map { |item| build_new_product(item[:item]) }.sort_by{ |prod| prod.nome }
  end

  def find_all_by_brand(brand_id)
    Rails.logger.debug "#{self.class}#find_all_by_brand"
    response = client.request :busca_avancada do
      soap.body = {
        :categoria_id => nil,
        :marca => brand_id
      }
    end
    
    array = response[:busca_avancada_response][:return][:item] || []
    array.map { |item| build_new_product(item[:item]) }.sort_by{ |prod| prod.nome }
  end
  
  def find(product_id)
    Rails.logger.debug "#{self.class}#find"
    begin
      response = client.request :exibe_detalhes_id do
        soap.body = {
          :id => product_id
        }
      end
      
      item = response[:exibe_detalhes_id_response][:return][:item]
      build_new_product(item)
    rescue Timeout::Error => e
      Rails.logger.info e.message
      raise "Timeout ao buscar produto"
    end
  end

  def find_image(product_id)
    Rails.logger.debug "#{self.class}#find_image"
    begin
      response = client.request :imagens_produto do
        soap.body = {
          :id => product_id
        }
      end
      #return response
      items = response[:imagens_produto_response][:return][:item]
      if !items.empty?
        item = if(items.is_a?(Array))
          items.first[:item]
        else
          items[:item]
        end
        build_new_image(item)
      else
        nil
      end
    rescue Timeout::Error => e
      Rails.logger.info e.message
      raise "Timeout ao buscar imagem"
    end
  end
  
  def search(query)
    Rails.logger.debug "#{self.class}#search"
    response = client.request :busca_por_strings do
      soap.body = {
        :palavras => query
      }
    end

    items = response[:busca_por_strings_response][:return][:item] || []
    array = items.is_a?(Array) ? items : [items]
    array.map { |item| build_new_product(item[:item]) }.sort_by{ |prod| prod.nome }
  end

  
  private
  
  def build_new_product(item)
    return nil unless item[0].to_i >= 0
    Product.new(:id             => item[0].to_i,
                :nome           => item[1].to_s,
                :categoria_id   => item[2].to_i,
                :categoria_nome => item[3].to_s,
                :marca_id       => item[4].to_i,
                :marca_nome     => item[5].to_s,
                :especificacao  => item[6].to_s,
                :peso           => item[7].to_f,
                :comprimento    => item[8].to_f,
                :largura        => item[9].to_f,
                :altura         => item[10].to_f)
  end

  def build_new_image(item)
    Product::ProductImage.new(:url_small => item[0],
                              :url       => item[1],
                              :descricao => item[2])
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://sql2.students.ic.unicamp.br/~ra043251/mc747/DetalheProduto.wsdl"
    end
  
  end
  
end