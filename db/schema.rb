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

ActiveRecord::Schema.define(:version => 20100205203846) do

  create_table "compilation_tracks", :force => true do |t|
    t.string  "name"
    t.integer "compilation_id",     :null => false
    t.integer "recording_track_id", :null => false
  end

  create_table "compilations", :force => true do |t|
    t.string "label"
    t.string "comments"
  end

  create_table "recording_tracks", :force => true do |t|
    t.string  "s3_bucket"
    t.string  "track"
    t.integer "recording_id", :null => false
  end

  create_table "recording_tracks_setlists", :id => false, :force => true do |t|
    t.integer "setlist_id",         :null => false
    t.integer "recording_track_id", :null => false
  end

  create_table "recordings", :force => true do |t|
    t.string  "label"
    t.text    "source"
    t.text    "lineage"
    t.string  "taper"
    t.string  "transfered_by"
    t.text    "notes"
    t.string  "type"
    t.string  "tracking_info"
    t.string  "shnid"
    t.string  "filetype"
    t.integer "show_id",       :null => false
  end

  create_table "setlists", :force => true do |t|
    t.integer "set_id"
    t.integer "song_order"
    t.text    "song_comments"
    t.boolean "is_segue"
    t.integer "show_id",       :null => false
    t.integer "song_id",       :null => false
  end

  create_table "shows", :force => true do |t|
    t.date    "date_played"
    t.text    "show_notes"
    t.integer "venue_id",    :null => false
  end

  create_table "songs", :force => true do |t|
    t.string  "song_name"
    t.text    "song_lyrics"
    t.string  "written_by"
    t.string  "original_performer"
    t.boolean "is_instrumental"
  end

  create_table "venues", :force => true do |t|
    t.string "venue_name"
    t.string "venue_image"
    t.string "venue_city"
    t.string "venue_state"
    t.string "venue_country"
  end

end