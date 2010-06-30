class AddRatingTables < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer             :entity_id, :null => false
      t.string              :rating_type, :null => false
      t.integer             :user_id, :null => false
      t.integer             :rating, :null => false
    end
  end

  def self.down
    drop_table :track_ratings
  end
end
