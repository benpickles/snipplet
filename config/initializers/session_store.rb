# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_snipplet_session',
  :secret      => '08af05bbd4b460f888c825301c8c72992d1782c6c4f0d45c298d6f14beb9c190c55caf4e1d4ef0bb92eb4670130c26b5e4695cd9a8769e506685314f2ac680eb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
