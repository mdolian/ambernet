class AddHaveWishLists < ActiveRecord::Migration
    def self.up
      create_table :have_lists do |t|
        t.integer             :recording_id, :null => false
        t.integer             :user_id, :null => false
      end
      create_table :wish_lists do |t|
        t.integer             :recording_id, :null => false
        t.integer             :user_id, :null => false
      end      
    end

    def self.down
      drop_table :have_lists
      drop_table :wish_lists
    end
end
