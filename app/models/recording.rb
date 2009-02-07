class Recording
  include DataMapper::Resource
  
  is_paginated
  
  property :id, Serial
  property :label, String
  property :source, String
  property :lineage, String
  property :taper, String
  property :transfered_by, String
  property :notes, String
  property :type, String
    
  belongs_to :show  
  has n, :recording_tracks
#  has n, :users, :through => Resource

end
