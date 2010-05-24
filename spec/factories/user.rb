#############
### Users ###
#############

Factory.sequence :email do |n|
  "user#{n}@localhost.com"
end

Factory.define :admin_user, :class => User do |u|
  u.name 'admin'
  u.login  'admin'
  u.email "admin@localhost.com"
  u.password "welcome"
  u.password_confirmation "welcome"
  u.password_salt(salt = Authlogic::Random.hex_token)
  u.crypted_password(Authlogic::CryptoProviders::Sha512.encrypt("welcome" + salt))
  u.persistence_token(Authlogic::Random.hex_token)
  u.single_access_token Authlogic::Random.friendly_token
  u.perishable_token Authlogic::Random.friendly_token
  u.admin true
end

Factory.define :user_one, :class => User do |u|
  u.name 'user_one'
  u.login  'user_one'
  u.email { Factory.next :email }
  u.password "welcome"
  u.password_confirmation "welcome"
  u.password_salt(salt = Authlogic::Random.hex_token)
  u.crypted_password(Authlogic::CryptoProviders::Sha512.encrypt("welcome" + salt))
  u.persistence_token(Authlogic::Random.hex_token)
  u.single_access_token Authlogic::Random.friendly_token
  u.perishable_token Authlogic::Random.friendly_token
end

Factory.define :user_two, :class => User do |u|
  u.name 'user_two'
  u.login  'user_two'
  u.email { Factory.next :email }
  u.password "welcome"
  u.password_confirmation "welcome"
  u.password_salt(salt = Authlogic::Random.hex_token)
  u.crypted_password(Authlogic::CryptoProviders::Sha512.encrypt("welcome" + salt))
  u.persistence_token(Authlogic::Random.hex_token)
  u.single_access_token Authlogic::Random.friendly_token
  u.perishable_token Authlogic::Random.friendly_token
end

Factory.define :invalid_user, :class => User do |u|
end