# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_admin_scaffold_session',
  :secret      => '074ab47b9933aa864ba4f621fc5e5b0787a37a202b645fb780c1bb807c091003b0bbf13c7ad8cbee9bda16cdeaa98dfb5ecfba953b4f6cebafb1686efb41443c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
