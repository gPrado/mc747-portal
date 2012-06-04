class CreatePurchases < ActiveRecord::Migration
  def up
    create_table :purchases do |t|
      t.string  :user_id,   :null => false
      t.boolean :completed, :null => false, :default => false
      t.timestamps
    end

    add_index :purchases, :user_id

    create_table :product_purchases do |t|
      t.integer :purchase_id,    :null => false
      t.string  :product_id,     :null => false
      t.integer :product_amount, :null => false, :default => 1
    end

    add_index :product_purchases, :purchase_id
  end

  def down
  end
end
