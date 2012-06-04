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

  class << self

    def from_user(user_id)
      user = UserFactory.instance.find(user_id)
      begin
        AddressFactory.instance.cep_address(user.cep)
      rescue Exception => e
        Rails.logger.info e
        Address.new(:cep => user.cep)
      end.tap do |a|
        a.numero      = user.numero_endereco
        a.complemento = user.complemento_endereco
      end
    end

  end

end