class AddShippingColumns < ActiveRecord::Migration
  def change
    add_column :purchases, :modo_entrega, :integer, :default => 1
    add_column :purchases, :shipping,     :string
    add_column :purchases, :cod_rastr,    :string
    
    add_column :product_purchases, :product_price, :string
  end
end
