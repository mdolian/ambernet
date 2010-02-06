class CreateCompilationTracks < ActiveRecord::Migration
  def self.up
    create_table :compilation_tracks do |t|
      t.string              :name
      t.integer             :compilation_id, :null => false
      t.integer             :recording_track_id, :null => false
    end
  end

  def self.down
    drop_table :compilation_tracks
  end
end
