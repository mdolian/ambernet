class Show
  include DataMapper::Resource
  
  property :id, Serial
  property :date_player, Date
  property :show_notes, Text
  property :audio_available, Boolean
  property :date_created, DateTime
  property :date_updated, DateTime
  property :updated_by, String
  property :is_active, Boolean
  
  has n, :setlists
  has n, :recordings
  belongs_to :venue
  
end
