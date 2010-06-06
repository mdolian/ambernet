class AddS3Information < ActiveRecord::Migration
  def self.up
    add_column :recordings, :s3_available, :integer
  end

  def self.down
    remove_column :recordings, :s3_available
  end
end
