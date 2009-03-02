class Venue
  include DataMapper::Resource
  
  property :id, Serial
  property :venue_name, String
  property :venue_image, String
  property :venue_city, String
  property :venue_state, String
  property :venue_country, String
  
  has n, :shows  
  
  def first
    id
  end
  
  def last
    venue_name
  end  
  
end
