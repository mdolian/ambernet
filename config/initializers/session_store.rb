# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_ambernet_session',
  :secret => 'e34c65d0060234db06592aea578d918b64bea9d70c3a53f74125314bb7d38f127cb352232d2701efb89714f6e35d7ee41036082b15a5dc63fb41e3ed5fdf0d1b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :cookie_store
