class Category
  attr_accessor :id, :nome, :id_pai, :filhos
  
  def initialize(params)
    @id     = params[:id]
    @nome   = params[:nome]
    @id_pai = params[:id_pai]
    @filhos = params[:filhos] || []
  end
  
  def to_s
    "#<Category @id=#{id} @nome=#{nome} @id_pai=#{id_pai} @filhos=#{filhos.inspect}>"
  end
end