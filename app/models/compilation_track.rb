class CompilationTrack
  include DataMapper::Resource
  
  property :id, Serial
  property :notes, String

  belongs_to :compilation
  has n, :recording_tracks

end