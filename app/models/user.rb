class User
  include DataMapper::Resource

  property :id, Serial
  property :login, String
  
  attr_accessor :password
  
  before :valid?, :encrypt_password

#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def encrypt_password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    self.crypted_password = encrypt(password)
    puts "PASS: #{crypted_password} #{password}"
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

end
