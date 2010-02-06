class CreateRecordingTracks < ActiveRecord::Migration
  def self.up
    create_table :recording_tracks do |t|
      t.string        :s3_bucket
      t.string        :track
      t.integer       :recording_id, :null => false
    end
  end

  def self.down
    drop_table :recording_tracks
  end
end
