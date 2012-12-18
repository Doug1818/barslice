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

ActiveRecord::Schema.define(:version => 20121209232054) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "bars", :force => true do |t|
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
    t.string   "name"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "phone"
    t.string   "website"
    t.boolean  "claimed",                :default => false
    t.integer  "click_count",            :default => 0
  end

  add_index "bars", ["email"], :name => "index_bars_on_email", :unique => true
  add_index "bars", ["reset_password_token"], :name => "index_bars_on_reset_password_token", :unique => true

  create_table "fees", :force => true do |t|
    t.integer  "room_id"
    t.integer  "amount"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hdctranges", :force => true do |t|
    t.integer  "room_id"
    t.integer  "min"
    t.integer  "max"
    t.boolean  "var_by_day"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hrsranges", :force => true do |t|
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "bar_id"
    t.integer  "open"
    t.integer  "close"
    t.boolean  "closed"
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "bar_id"
    t.integer  "reservation_id"
    t.boolean  "sent_by"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "reservations", :force => true do |t|
    t.date     "date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "hdct"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "room_id"
    t.integer  "user_id"
    t.integer  "bar_response"
    t.integer  "user_response"
    t.datetime "bar_accepts_date"
    t.datetime "bar_rejects_date"
    t.datetime "user_accepts_date"
    t.datetime "user_rejects_date"
  end

  create_table "respolicies", :force => true do |t|
    t.integer  "bar_id"
    t.text     "description"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "policydoc_file_name"
    t.string   "policydoc_content_type"
    t.integer  "policydoc_file_size"
    t.datetime "policydoc_updated_at"
    t.integer  "delete_policydoc"
  end

  create_table "restrictions", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_id"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "before"
    t.integer  "after"
    t.integer  "exists"
  end

  create_table "rmsprelationships", :force => true do |t|
    t.integer  "room_id"
    t.integer  "special_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "location"
    t.string   "bar_name"
    t.date     "date"
    t.integer  "hdct"
    t.integer  "privacy"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "start_time"
    t.integer  "end_time"
    t.boolean  "no_fee"
    t.boolean  "no_spendmin"
    t.boolean  "has_open_bar"
  end

  create_table "specials", :force => true do |t|
    t.integer  "bar_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "from"
    t.integer  "until"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.integer  "min_hdct"
    t.boolean  "open_bar"
    t.boolean  "food"
    t.string   "name"
  end

  create_table "spendmins", :force => true do |t|
    t.integer  "room_id"
    t.integer  "min"
    t.boolean  "per_person"
    t.boolean  "var_by_day"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
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
    t.boolean  "admin"
    t.string   "name"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
