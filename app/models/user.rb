class User
  
  attr_accessor :cpf, :nome, :data_nascimento, :dat_cCadastro, :rg, :cep,
                :numero_endereco, :complemento_endereco, :potencial_compra, :email

  def initialize(params)
    @cpf                  = params[:cpf]
    @nome                 = params[:nome]
    @data_nascimento      = params[:data_nascimento]
    @data_cadastro        = params[:data_cadastro]
    @rg                   = params[:rg]
    @cep                  = params[:cep]
    @numero_endereco      = params[:numero_endereco]
    @complemento_endereco = params[:complemento_endereco]
    @potencial_compra     = params[:potencial_compra]
    @email                = params[:email]
  end

end
