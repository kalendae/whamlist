# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_whamlist_session',
  :secret      => '82853cf8e35de8e39acc5d0cb6590c23e314144e3108848f6a376155b39ed116db8174bb715043b3b65ed6fd19c46f5ceb28e065aa481eb32c36438b41354fd7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
