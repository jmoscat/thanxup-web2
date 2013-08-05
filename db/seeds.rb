# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.find_or_create_by_username(:username => "admin", :email => 'admin@example.com', :role => 'admin', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "molly", :email => 'molly@example.com', :role => 'manager', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "fred", :email => 'fred@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "guest", :email => 'guest@example.com', :role => 'guest', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "felix", :email => 'felix@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "suzy", :email => 'suzy@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "jane", :email => 'jane@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
User.find_or_create_by_username(:username => "darcy", :email => 'darcy@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
