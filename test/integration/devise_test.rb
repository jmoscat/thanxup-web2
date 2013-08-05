require 'test_helper'

# Placeholder: 
# need to integrate behavoir driven integration testing that handles the AJAX devise forms
# possilibity is https://github.com/thoughtbot/capybara-webkit ?
#

class DeviseTest < ActionDispatch::IntegrationTest
  
  test 'home should be accessible without sign in' do   
    get '/'
    assert_response :success
    assert_select 'h3', "Welcome! Hello world!"
  end
  
  test 'valid user login' do
    post "/users/sign_in", "user"=>{"username"=>"fred", "password"=>"123123"}
    assert_response :success
  end
end
