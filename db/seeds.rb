# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#User.find_or_create_by_username(:username => "admin", :email => 'admin@example.com', :role => 'admin', :password => '123123', :password_confirmation => '123123')

Database.delete_all
api = Database.new
api.db_id = 1
api.source = "api"
api.server = "94.23.32.166"
api.port = 27017
api.db_name = "thanxup-api"
api.user = "thanxup-api-bi"
api.password = "Freapi1903"
api.save

cupon = Database.new
cupon.db_id = 2
cupon.source = "cupon"
cupon.server = "46.105.16.167"
cupon.port = 27017
cupon.db_name = "thanxup-cupon"
cupon.user = "thanxup-cupon-bi"
cupon.password = "BiCup19032011"
cupon.save