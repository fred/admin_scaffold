# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

User.create(:name => "admin", 
  :login => "admin",
  :email => "admin@localhost.com",
  :password => "welcome", 
  :password_confirmation => "welcome",
  :admin => true
)
user = User.find(:first)
if user
  user.admin = true
  user.save
end
