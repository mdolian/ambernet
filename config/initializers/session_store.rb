# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ambernet_session',
  :secret      => 'b7a603aa5fb5f0c713980c0675b48d2323dde180fc8837c5a6da60355fc7df973c26d618f6d2baaf91924328c359fcc71f5d1ce8605de599e5689975a8160ee2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
