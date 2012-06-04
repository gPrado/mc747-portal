class Shipping

  attr_accessor :fee, :estimated_time

  def initialize(params)
    @fee            = params[:fee]
    @estimated_time = params[:estimated_time]
  end

end