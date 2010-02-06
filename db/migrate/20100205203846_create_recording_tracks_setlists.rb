class CreateRecordingTracksSetlists < ActiveRecord::Migration
  def self.up
    create_table :recording_tracks_setlists, :id => false do |t|
      t.integer     :setlist_id, :null => false      
      t.integer     :recording_track_id, :null => false
    end
  end

  def self.down
    drop_table :recording_tracks_setlists
  end
end
