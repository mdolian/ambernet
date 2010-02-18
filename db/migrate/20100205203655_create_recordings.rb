class CreateRecordings < ActiveRecord::Migration
  def self.up
    create_table :recordings do |t|
      t.string        :label
      t.text          :source
      t.text          :lineage
      t.string        :taper
      t.string        :transfered_by
      t.text          :notes
      t.string        :type
      t.string        :tracking_info
      t.string        :shnid
      t.string        :filetype      
      t.integer       :show_id, :null => false
    end
  end

  def self.down
    drop_table :recordings
  end
end
