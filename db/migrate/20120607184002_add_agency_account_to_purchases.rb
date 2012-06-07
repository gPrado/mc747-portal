class AddAgencyAccountToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :agency, :string
    add_column :purchases, :account, :string
  end
end
