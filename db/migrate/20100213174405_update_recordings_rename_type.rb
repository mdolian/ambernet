class UpdateRecordingsRenameType < ActiveRecord::Migration
  def self.up
    change_table :recordings do |t|
      t.rename :type, :recording_type
    end
  end

  def self.down
    change_table :recordings do |t|
      t.rename :recording_type, :type
    end    
  end
end
