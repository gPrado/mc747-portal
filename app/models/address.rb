class Address
  attr_accessor :cep, :logradouro, :bairro, :localidade, :uf
  
  def initialize(params)
    @cep        = params[:cep]
    @logradouro = params[:logradouro]
    @bairro     = params[:bairro]
    @localidade = params[:localidade]
    @uf         = params[:uf]
  end
  
  def to_s
    "#<Address @cep=#{cep} @logradouro=#{logradouro} @bairro=#{bairro} @localidade=#{localidade}> @uf=#{uf}"
  end
end