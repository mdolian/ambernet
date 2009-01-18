class Show
  include DataMapper::Resource
  
  property :id, Serial
  property :date_played, Date
  property :show_notes, Text
  property :audio_available, Boolean
  property :date_created, DateTime
  property :date_updated, DateTime
  property :updated_by, String
  property :is_active, Boolean
  
  has n, :setlists
  has n, :recordings
  belongs_to :venue
  
  def first
    id
  end
  
  def last
    date_played
  end
  
  def label
    date_played.to_s << " - " << venue.venue_name << " " << venue.venue_city << ", " << venue.venue_state
  end
  
  def setlists
    Setlist.all(:show_id => id, :order => [:set_id.asc, :song_order.asc])
  end
end