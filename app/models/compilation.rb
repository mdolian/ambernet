class Compilation
  include DataMapper::Resource
  
  property :id, Serial
  property :label, String
  property :comments, String

  has n, :compilation_tracks

end