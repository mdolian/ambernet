class Venue
  include DataMapper::Resource
  
  property :id, Serial
  property :venue_name, String
  property :venue_image, String
  property :venue_city, String
  property :venue_state, String
  property :date_created, DateTime
  property :date_updated, DateTime
  property :updated_by, Integer
  property :is_active, Boolean
  
  has n, :shows  
  
  def first
    id
  end
  
  def last
    venue_name
  end
  
end
