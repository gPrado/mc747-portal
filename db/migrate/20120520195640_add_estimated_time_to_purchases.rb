class AddEstimatedTimeToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :estimated_time, :integer
  end
end
