# encoding: utf-8
class CustomerService
  
  attr_accessor :id, :tipo, :descricao, :user_id, :date, :status, :updates
  
  def initialize(params)
    @id        = params[:id]
    @tipo      = params[:tipo]
    @descricao = params[:descricao]
    @user_id   = params[:user_id]
    @date      = params[:date]
    @status    = params[:status]
    @updates   = params[:updates]
  end

  def human_tipo
    self.class.available_types[tipo]
  end

  def human_status
    self.class.available_status[status]
  end

  class << self
    
    def available_types
      ["Reclamação", "Sugestão", "Troca", "Dúvida", "Outro"]
    end
    
    def available_status
      ["Aberto", "Fechado", "Em Andamento", "Cancelado"]
    end
    
  end
  
end
