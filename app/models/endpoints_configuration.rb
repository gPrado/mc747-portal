class EndpointsConfiguration < ActiveRecord::Base
  validates :address_service, :presence => true, :allow_blank => false

  private_class_method :new, :create, :initialize

  class << self

    def init
      unless self.conf
        new_conf = new do |c|
          c.address_service = "group09"
        end
        new_conf.save!
      end
    end

    def conf
      @conf ||= EndpointsConfiguration.first
    end

    def conf=(conf_attr)
      self.conf.update_attributes!(conf_attr)
    end

  end

end