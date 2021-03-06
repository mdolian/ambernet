class Venue < ActiveRecord::Base
  
  attr_accessible :id, :venue_name, :venue_image, :venue_city, :venue_state, :venue_country
  
  has_many :shows
  has_many :recordings, :through => :shows  
  
  def first
    id
  end
  
  def last
    venue_name
  end  

  def self.per_page
    25
  end
  
  def venue_label
    venue_name + " " + venue_city + ", " + venue_state
  end
  
  define_index do
    indexes venue_name, :sortable => true
    indexes venue_city, :sortable => true
    indexes venue_state, :sortable => true        
    indexes venue_country, :sortable => true
  end
    
end
