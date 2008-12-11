class Recording
  include DataMapper::Resource
  
  property :id, Serial
  property :label, String
  property :source, String
  property :lineage, String
  property :taper, String
  property :transfered_by, String
  property :notes, String
    
  belongs_to :show  
  has n, :recording_tracks
#  has n, :users, :through => Resource

end
