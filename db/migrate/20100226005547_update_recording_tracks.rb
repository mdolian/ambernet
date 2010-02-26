class UpdateRecordingTracks < ActiveRecord::Migration
  def self.up
    drop_table :recording_tracks_setlists
    drop_table :recording_tracks
    create_table :recording_tracks do |t|
      t.integer       :track
      t.integer       :recording_id, :null => false
      t.integer       :song_id_start, :null => false
      t.integer       :song_id_end, :null => false
    end    
  end

  def self.down
    drop_table :recording_tracks   
  end
end
