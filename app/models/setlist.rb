class Setlist
  include DataMapper::Resource
  
  property :id, Serial
  property :set_id, String
  property :song_order, String
  property :song_comments, Text
  property :is_segue, Boolean
  property :date_created, Date
  property :date_updated, Date
  property :time_updated, DateTime
  property :updated_by, String
  property :is_active, Boolean
  
  belongs_to :show
  belongs_to :song
  has n, :recording_tracks, :through => Resource
  
end
