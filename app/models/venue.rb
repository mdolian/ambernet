class Venue < ActiveRecord::Base
  
  #t.string      :venue_name
  #t.string      :venue_image
  #t.string      :venue_city
  #t.string      :venue_state
  #t.string      :venue_country
  
  has_many :shows  
  
  def first
    id
  end
  
  def last
    venue_name
  end  

  def self.per_page
    100
  end
  
  def label
    venue_name + " " + venue_city + ", " + venue_state
  end
 
#  define_index do
#    indexes venue_name, :sortable => true
#    indexes venue_city, :sortable => true
#    indexes venue_state, :sortable => true        
#    indexes venue_country, :sortable => true

#    has venue_name, venue_city, venue_state, venue_image, venue_country
#  end
    
end
