class AddAddressColumnsToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :cep, :string, :null => false, :default => "13083-852"
    add_column :purchases, :logradouro, :string
    add_column :purchases, :bairro, :string
    add_column :purchases, :localidade, :string
    add_column :purchases, :uf, :string
    add_column :purchases, :complemento, :string
    add_column :purchases, :numero, :string, :null => false, :default => "34"
  end
end
