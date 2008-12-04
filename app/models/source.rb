class Source
  include DataMapper::Resource
  
  property :id, Serial
  property :label, String
  property :source, String
  property :lineage, String
  property :taper, String
  property :transfered_by, String
  property :notes, String
  
  belongs_to :recording
  has n, :have_lists
  has n, :users, :through => :have_lists

end
