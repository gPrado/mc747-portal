# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120517040817) do

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "endpoints_configurations", :force => true do |t|
    t.string "address_service", :null => false
  end

  create_table "product_purchases", :force => true do |t|
    t.integer "purchase_id",                   :null => false
    t.string  "product_id",                    :null => false
    t.integer "product_amount", :default => 1, :null => false
  end

  add_index "product_purchases", ["purchase_id"], :name => "index_product_purchases_on_purchase_id"

  create_table "purchases", :force => true do |t|
    t.string   "user_id",                       :null => false
    t.boolean  "completed",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "purchases", ["user_id"], :name => "index_purchases_on_user_id"

end
