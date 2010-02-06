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
  
end
