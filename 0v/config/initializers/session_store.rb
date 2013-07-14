# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_0v_session',
  :secret      => '88a25599a661914f0c318909b2ff1fbe7f95f598c73a3a483ae5a6a97bd1ce6f2f0026a72a4e4490ecc6ee2244330dd92b09f34e17945c0484ae1edaa3570638'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
