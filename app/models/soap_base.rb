class SoapBase
  
  private_class_method :new
  
  private
  
  def client
    wsdl_doc = wsdl
    Savon::Client.new do
      wsdl.document = wsdl_doc
    end
  end
  
  def wsdl
    self.class.wsdl
  end
  
  class << self
    
    def instance
      new
    end
    
    def default_wsdl
      raise NotImplementedError
    end
    
    def wsdl
      #TODO @@wsdl = default_wsdl doesn't work
      default_wsdl
    end
    
    def configure(wsdl)
      #TODO
      @@wsdl = wsdl
    end  
    
  end
end