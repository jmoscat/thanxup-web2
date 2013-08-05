require 'test_helper'

# NOTE: The request.env assignment is so devise knows about the local overridding controllers
#

class AdminControllerTest < ActionController::TestCase

  test 'add new user from admin page form' do
    # need to be logged in as an admin
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in User.find_by_username('admin')
    assert :success
    
    post :add_new_user, :user => {:username => "john", :email => "john@example.com"}
    assert :success
    assert_redirected_to "/admin"
  end

  test 'edit username from admin page table' do
    # need to be logged in as an admin
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in User.find_by_username('admin')
    assert :success

    user = User.find_by_username('molly')
    post :update_user, { :user => { :username => "maggie"}, :id => user.id}
    assert :success
    assert_redirected_to "/admin"
    
    user = User.find_by_username('maggie')
    assert :success    
  end

  test 'delete user from admin page table' do
    # need to be logged in as an admin
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in User.find_by_username('admin')
    assert :success
    
    user = User.find_by_username('suzy')
    delete :delete_user, { :id => user.id }
    assert :success
    assert_redirected_to "/admin"
    
    user = User.find_by_username('suzy')
    assert :fail    
  end

end
