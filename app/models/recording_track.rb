class RecordingTrack
  include DataMapper::Resource
  
  property :id, Serial
  property :s3_bucket, String
  property :track, String

  belongs_to :recording
  has n, :setlists, :through => Resource

end
