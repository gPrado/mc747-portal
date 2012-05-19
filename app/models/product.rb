class Product
  
  attr_accessor :id, :nome, :categoria_id, :categoria_nome, :marca_id, :marca_nome,
                :especificacao, :peso, :comprimento, :largura, :altura

  def initialize(params)
    @id             = params[:id]
    @nome           = params[:nome]
    @categoria_id   = params[:categoria_id]
    @categoria_nome = params[:categoria_nome]
    @marca_id       = params[:marca_id]
    @marca_nome     = params[:marca_nome]
    @especificacao  = params[:especificacao]
    @peso           = params[:peso]
    @comprimento    = params[:comprimento]
    @largura        = params[:largura]
    @altura         = params[:altura]
  end

  def price
    @price ||= product_info.price
  end
  
  def quantity
    product_info.quantity
  end

  def volume
    comprimento * altura * largura
  end

  private
  
  def product_info
    @product_info ||= ProductInfoFactory.instance.find id
  end

end