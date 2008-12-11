class HaveList
  include DataMapper::Resource
  
  property :id, Serial
  property :format, String
  property :rating, String
  property :comments, String
  
#  belongs_to :user
#  belongs_to :source

end
