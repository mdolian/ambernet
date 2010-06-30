class User < ActiveRecord::Base

  devise :database_authenticatable, :oauth2_authenticatable

  attr_accessible :email, :password, :password_confirmation

  has_many :have_lists
  has_many :wish_lists

end
