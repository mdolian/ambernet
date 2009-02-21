class RecordingDisc
  include DataMapper::Resource
  
  property :id, Serial
  property :disc, Integer
  property :tracks, Integer
  
  belongs_to :recording
  
end
