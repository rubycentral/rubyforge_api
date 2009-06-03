# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_api_session',
  :secret      => '53b68f229ac5cef6bab80e088366652d1e038346e29f4e9e9247106324fd4c5e02e98db47958eb69f99268de07d1e2e443de835928a6a8f52a28184601a4c29f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
