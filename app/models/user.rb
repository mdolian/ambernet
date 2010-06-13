class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :access_token

#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

  scope :by_access_token, lambda { |access_token|
    where("access_token = ?", access_token)
  }
  
end
