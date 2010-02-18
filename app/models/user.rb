class User < ActiveRecord::Base

#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

  devise :registerable, :authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation
  
end
