class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.date        :date_played
      t.text        :show_notes
      t.integer     :venue_id, :null => false
    end
  end

  def self.down
    drop_table :shows
  end
end
