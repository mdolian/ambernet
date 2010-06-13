class UpdateAdminsWithAccessToken < ActiveRecord::Migration
  def self.up
    add_column :admins, :access_token, :string
  end

  def self.down
  end
end
