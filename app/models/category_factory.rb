class CategoryFactory < SoapBase
  
  def all
    r = raw
    r.sort_by{ |c| c.nome }.each do |c|
      if c.id_pai
        r.find{ |pai| pai.id == c.id_pai }.filhos << c
      end
    end.delete_if{ |c| c.id_pai }
  end
  
  def find(id)
    raw.find{ |c| c.id == id }
  end
  
  private
  
  def raw
    Rails.logger.debug "#{self.class}#raw"
    response = client.request :listar_categorias
    array = response[:listar_categorias_response][:return][:item] || []
    array.map do |item|
      Category.new(:id      => item[:item][0].to_i,
                   :id_pai  => item[:item][1] && item[:item][1].to_i,
                   :nome    => item[:item][2].to_s)
    end
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://sql2.students.ic.unicamp.br/~ra043251/mc747/DetalheProduto.wsdl"
    end
  
  end
  
end