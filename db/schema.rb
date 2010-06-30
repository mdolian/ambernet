# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100630224823) do

  create_table "admins", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "encrypted_password",   :limit => 40, :null => false
    t.string   "password_salt",                      :null => false
    t.string   "reset_password_token", :limit => 20
    t.string   "remember_token",       :limit => 20
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "compilation_tracks", :force => true do |t|
    t.string  "name"
    t.integer "compilation_id",     :null => false
    t.integer "recording_track_id", :null => false
  end

  create_table "compilations", :force => true do |t|
    t.string "label"
    t.string "comments"
  end

  create_table "have_lists", :force => true do |t|
    t.integer "recording_id", :null => false
    t.integer "user_id",      :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer "entity_id",   :null => false
    t.string  "rating_type", :null => false
    t.integer "user_id",     :null => false
    t.integer "rating",      :null => false
  end

  create_table "recording_tracks", :force => true do |t|
    t.integer "track"
    t.integer "recording_id", :null => false
    t.integer "song_id",      :null => false
  end

  create_table "recording_tracks_setlists", :id => false, :force => true do |t|
    t.integer "setlist_id",         :null => false
    t.integer "recording_track_id", :null => false
  end

  create_table "recordings", :force => true do |t|
    t.string  "label",          :limit => 50
    t.text    "source"
    t.text    "lineage"
    t.string  "taper",          :limit => 50
    t.string  "transfered_by",  :limit => 50
    t.text    "notes"
    t.string  "recording_type", :limit => 50
    t.string  "tracking_info",  :limit => 50
    t.string  "shnid",          :limit => 50
    t.string  "filetype",       :limit => 8
    t.integer "show_id"
    t.integer "s3_available"
  end

  create_table "setlists", :force => true do |t|
    t.integer "set_id"
    t.integer "song_order"
    t.text    "song_comments"
    t.boolean "is_segue"
    t.integer "show_id"
    t.integer "song_id"
  end

  create_table "shows", :force => true do |t|
    t.date    "date_played"
    t.text    "show_notes"
    t.integer "venue_id"
  end

  create_table "songs", :force => true do |t|
    t.string  "song_name",          :limit => 100
    t.text    "song_lyrics"
    t.string  "written_by",         :limit => 50
    t.string  "original_performer", :limit => 50
    t.boolean "is_instrumental"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.string   "password_salt",                     :default => "", :null => false
    t.integer  "oauth2_uid",         :limit => 8
    t.string   "oauth2_token",       :limit => 149
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["oauth2_uid"], :name => "index_users_on_oauth2_uid", :unique => true

  create_table "venues", :force => true do |t|
    t.string "venue_name",    :limit => 50
    t.string "venue_image",   :limit => 50
    t.string "venue_city",    :limit => 50
    t.string "venue_state",   :limit => 50
    t.string "venue_country", :limit => 50
  end

  create_table "wish_lists", :force => true do |t|
    t.integer "recording_id", :null => false
    t.integer "user_id",      :null => false
  end

end
