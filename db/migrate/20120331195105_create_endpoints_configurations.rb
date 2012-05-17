class CreateEndpointsConfigurations < ActiveRecord::Migration
  def up
    create_table :endpoints_configurations do |t|
      t.string :address_service, :null => false
    end
    EndpointsConfiguration.init
  end
  
  def down
    drop_table :endpoints_configurations
  end
end
