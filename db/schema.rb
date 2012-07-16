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

ActiveRecord::Schema.define(:version => 20120716192331) do

  create_table "bars", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "phone"
  end

  add_index "bars", ["email"], :name => "index_bars_on_email", :unique => true
  add_index "bars", ["reset_password_token"], :name => "index_bars_on_reset_password_token", :unique => true

  create_table "restrictions", :force => true do |t|
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_id"
  end

  create_table "roompics", :force => true do |t|
    t.string   "description"
    t.integer  "room_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.integer  "bar_id"
    t.string   "name"
    t.integer  "privacy"
    t.integer  "min_head_count"
    t.integer  "max_head_count"
    t.text     "description"
    t.integer  "min_spend"
    t.boolean  "per_person"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "mon1"
    t.boolean  "mon1ap"
    t.integer  "mon2"
    t.boolean  "mon2ap"
    t.integer  "tues1"
    t.boolean  "tues1ap"
    t.integer  "tues2"
    t.boolean  "tues2ap"
    t.integer  "wed1"
    t.boolean  "wed1ap"
    t.integer  "wed2"
    t.boolean  "wed2ap"
    t.integer  "thurs1"
    t.boolean  "thurs1ap"
    t.integer  "thurs2"
    t.boolean  "thurs2ap"
    t.integer  "fri1"
    t.boolean  "fri1ap"
    t.integer  "fri2"
    t.boolean  "fri2ap"
    t.integer  "sat1"
    t.boolean  "sat1ap"
    t.integer  "sat2"
    t.boolean  "sat2ap"
    t.integer  "sun1"
    t.boolean  "sun1ap"
    t.integer  "sun2"
    t.boolean  "sun2ap"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
