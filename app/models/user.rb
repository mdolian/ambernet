# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User
  include DataMapper::Resource
  
  property :id,     Serial
  property :login,  String
  property :user_type, String
  property :user_name, String
  property :email, String
  property :phone, String
  property :first_name, String
  property :last_name, String
  property :maiden_name, String
  property :address_1, String
  property :address_2, String
  property :city_name, String
  property :state_name, String
  property :zip_code, String
  property :setlist_display, String
  property :im_msn, String
  property :im_yahoo, String
  property :im_aol, String
  property :my_space_url, String
  property :date_logged_in, DateTime
  property :date_created, DateTime
  property :date_updated, DateTime
  property :time_updated, DateTime
  property :is_private, Boolean
  property :is_active, Boolean
  
  has n, :have_lists
  has n, :sources, :through => :have_lists
  has n, :wish_lists
  has n, :recordings, :thorough => :wish_lists 
  
end
