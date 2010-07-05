class RemoveWishLists < ActiveRecord::Migration
  def self.up
    drop_table :wish_lists
  end

  def self.down
    create_table :wish_lists do |t|
      t.integer             :recording_id, :null => false
      t.integer             :user_id, :null => false
    end    
  end
end
