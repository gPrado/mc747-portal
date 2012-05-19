class AddPaymentColumns < ActiveRecord::Migration
  def change
    add_column :purchases, :payment_count, :integer, :default => 1
    add_column :purchases, :payment_type,  :string, :default => :boleto
    add_column :purchases, :payment_id,    :string
    add_column :purchases, :cc_numero,     :string
    add_column :purchases, :cc_nome,       :string
    add_column :purchases, :cc_validade,   :string
    add_column :purchases, :cc_codigo,     :string
    add_column :purchases, :cc_bandeira,   :string, :default => :visa
  end
end
