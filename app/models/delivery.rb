class Delivery
  attr_accessor :cod_rastr, :id_status
  
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