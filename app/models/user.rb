class User
  
  attr_accessor :cpf, :nome, :dataNascimento, :dataCadastro, :rg, :cep,
                :numeroEndereco, :complementoEndereco, :potencialCompra, :email

  def initialize(params)
    @cpf                  = params[:cpf]
    @nome                 = params[:nome]
    @dataNascimento       = params[:dataNascimento]
    @dataCadastro         = params[:dataCadastro]
    @rg                   = params[:rg]
    @cep                  = params[:cep]
    @numeroEndereco       = params[:numeroEndereco]
    @complementoEndereco  = params[:complemento]
    @potencialCompra      = params[:potencial]
    @email                = params[:email]
  end

end