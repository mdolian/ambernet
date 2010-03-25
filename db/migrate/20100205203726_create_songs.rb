class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string              :song_name
      t.text                :song_lyrics
      t.string              :written_by
      t.string              :original_performer
      t.integer             :instrumental
    end
  end

  def self.down
    drop_table :songs
  end
end
