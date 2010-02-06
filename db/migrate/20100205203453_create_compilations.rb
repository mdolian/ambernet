class CreateCompilations < ActiveRecord::Migration
  def self.up
    create_table :compilations do |t|
      t.string    :label
      t.string    :comments
    end
  end

  def self.down
    drop_table :compilations
  end
end
