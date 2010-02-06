class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string      :venue_name
      t.string      :venue_image
      t.string      :venue_city
      t.string      :venue_state
      t.string      :venue_country
    end
  end

  def self.down
    drop_table :venues
  end
end
