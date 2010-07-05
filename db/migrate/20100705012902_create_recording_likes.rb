class CreateRecordingLikes < ActiveRecord::Migration
  def self.up
    create_table :recording_likes do |t|
      t.integer             :recording_id, :null => false
      t.integer             :user_id, :null => false
    end
  end

  def self.down
    drop_table :recording_likes
  end
end
