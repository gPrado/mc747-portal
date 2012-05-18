class Address
  attr_accessor :cep, :logradouro, :bairro, :localidade, :uf, :numero, :complemento
  
  def initialize(params)
    @cep          = params[:cep]
    @logradouro   = params[:logradouro]
    @bairro       = params[:bairro]
    @localidade   = params[:localidade]
    @uf           = params[:uf]
    @numero       = params[:numero]
    @complemento  = params[:complemento]
  end
  
  def to_s
    "#<Address @cep=#{cep} @logradouro=#{logradouro} @bairro=#{bairro} @localidade=#{localidade}> @uf=#{uf} @numero=#{numero} @complemento=#{complemento}"
  end
end