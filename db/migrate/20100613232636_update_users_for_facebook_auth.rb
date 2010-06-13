class UpdateUsersForFacebookAuth < ActiveRecord::Migration
  def self.up
    remove_column :users, :encrypted_password
    remove_column :users, :password_salt
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :reset_password_token
    remove_column :users, :remember_token
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :updated_at
    
    add_column :users, :name, :string
    
  end

  def self.down
    add_column :users, :encrypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :date
    add_column :users, :confirmation_sent_at, :date
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_created_at, :date
    add_column :users, :sign_in_count, :integer
    add_column :users, :current_sign_in_at, :date
    add_column :users, :last_sign_in_at, :date
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :updated_at, :date
    
    remove_column :users, :name
    
  end
end
