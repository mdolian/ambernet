class RecordingTrack
  include DataMapper::Resource
  
  property :id, Serial

  belongs_to :recording
  has n, :setlists, :through => Resource

end
