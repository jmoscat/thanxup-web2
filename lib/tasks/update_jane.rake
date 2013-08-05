namespace :update_jane do

	desc %{reset username 'jane' to default '123123' password}
	task :reset_to_default_password => :environment do |t|
    jane = User.find_or_create_by_username(:username => "jane", :email => 'jane@example.com', :role => 'user', :password => '123123', :password_confirmation => '123123')
    jane.update_attribute :password, "123123"
	end

end
