Devise.setup do |config|
  config.mailer_sender = "admin@ambernetonline.net"

  require 'devise/orm/active_record'

  config.encryptor = :sha1

end
