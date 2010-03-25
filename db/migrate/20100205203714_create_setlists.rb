class CreateSetlists < ActiveRecord::Migration
  def self.up
    create_table :setlists do |t|
      t.integer       :set_id
      t.integer       :song_order
      t.text          :song_comments
      t.integer       :segue
      t.integer       :show_id, :null => false
      t.integer       :song_id, :null => false
    end
  end

  def self.down
    drop_table :setlists
  end
end
