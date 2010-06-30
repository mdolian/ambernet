class UpdateUsersForDeviseOauth2Authenticatable < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.oauth2_authenticatable
      t.string :email

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :oauth2_uid, :unique => true
  end

  def self.down
    drop_table :users
  end
end
