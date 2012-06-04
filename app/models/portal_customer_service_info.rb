class PortalCustomerServiceInfo

  include Singleton

  def key
    config_yaml['customer_service_key']
  end

  private

  def config_file
    "#{Rails.root}/config/portal_info.yml"
  end

  def config_yaml
    YAML::load_file config_file
  end

end
