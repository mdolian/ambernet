class UpdateUsersWithAccessToken < ActiveRecord::Migration
  def self.up
    add_column :users, :access_token, :string
  end

  def self.down
  end
end
