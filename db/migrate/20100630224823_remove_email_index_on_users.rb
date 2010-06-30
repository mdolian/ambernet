class RemoveEmailIndexOnUsers < ActiveRecord::Migration
  class UpdateUsersForDeviseOauth2Authenticatable < ActiveRecord::Migration
    def self.up
      remove_index :users, :email, :unique => true
    end

    def self.down
      add_index :users, :email, :unique => true
    end
  end
end
