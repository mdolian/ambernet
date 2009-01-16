class User
  include DataMapper::Resource
#  include Merb::Authentication::Mixins::SaltedUser

  property :id, Serial
  property :email, String, :format=>:email_address
  property :login, String, :nullable=>false
  property :user_type, String
  property :user_name, String
  property :email, String, :format=>:email_address
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
  
#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

end
