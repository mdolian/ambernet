class User
  include DataMapper::Resource

  property :id, Serial
  property :login, String

#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

end
