class EndpointsConfigurationsController < ApplicationController
  def edit
    @configuration = EndpointsConfiguration.conf
  end

  def update
    EndpointsConfiguration.conf = params[:endpoints_configuration]
    flash[:notice] = "Update Successful"
    redirect_to :root
  rescue
    flash[:alert] += "There were validations errors"
    redirect_to :edit_endpoint_configuration_path
  end
end
