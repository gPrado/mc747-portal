class PortalAccountInfo
  
  include Singleton
  
  def account
    config_yaml['account']
  end
  
  def agency
    config_yaml['agency']
  end
  
  private
  
  def config_file
    "#{Rails.root}/config/portal_account.yml"
  end
  
  def config_yaml
    YAML::load_file config_file
  end
  
end
