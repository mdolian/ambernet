class Venue
  include DataMapper::Resource
  
  property :id, Serial
  property :venue_name, String
  property :venue_image, String, :lazy => true
  property :venue_citye, String, :lazy => true
  property :venue_state, String, :lazy => true
  property :date_created, DateTime, :lazy => true
  property :date_updated, DateTime, :lazy => true
  property :updated_by, Integer, :lazy => true
  property :is_active, Boolean, :lazy => true
  
  has n, :shows  
  
  def collect
    Venue.all
  end
  
end
