class ConvertFromHeroku < ActiveRecord::Migration
  def self.up
    change_column :setlists, :is_segue, :boolean
    change_column :songs, :is_instrumental, :boolean  
  end

  def self.down
    change_column :setlists, :is_segue, :integer
    change_column :songs, :is_instrumental, :integer  
  end
end