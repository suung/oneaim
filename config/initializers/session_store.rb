# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oneaim_session',
  :secret      => '33752012fd7b2cccbc8bcf21f5ffa7f5f5f6d7ccc616c81b5621525013d4f27d9e921c65024046ffd1144d509416ee6c06d2770487b84cea124b6ce706136f0d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
