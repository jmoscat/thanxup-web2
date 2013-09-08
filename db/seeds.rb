# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#User.find_or_create_by_username(:username => "admin", :email => 'admin@example.com', :role => 'admin', :password => '123123', :password_confirmation => '123123')


api = Database.new
api.db_id = 1
api.source = "api"
api.server = "ds059957.mongolab.com"
api.port = 59957
api.db_name = "thanxup-prod"
api.user = "thanxup-prod"
api.password = "19032011"
api.save

cupon = Database.new
cupon.db_id = 2
cupon.source = "cupon"
cupon.server = "ds059957.mongolab.com"
cupon.port = 59957
cupon.db_name = "thanxup-cupon"
cupon.user = "thanxup-cupon"
cupon.password = "19032011"
cupon.save