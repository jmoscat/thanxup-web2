require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "username wrong length" do
    user = User.find_by_username("fred")
    user.username = "12"
    assert !user.save, "Username too short"
    user.username = "123123123123123123123"
    assert !user.save, "Username too long"    
  end

  test "username or email not unique" do
    user = User.find_by_username("fred")
    user.username = "molly"
    assert !user.save, "Username not unique"
    user.email = "molly@example.com"
    assert !user.save, "Email not unique"
  end
  
  # now test roles handled in user model

  test "guest role limits" do
    guest = User.find_by_username("guest")
    assert guest.role?('guest')
    assert !guest.is_admin?
    assert guest.role_access?('guest')
    assert !guest.role_access?('user')
    assert !guest.role_access?('manager')
    assert !guest.role_access?('admin')
  end

  test "user role limits" do
    fred = User.find_by_username("fred")
    assert fred.role?('user')
    assert !fred.is_admin?
    assert fred.role_access?('guest')
    assert fred.role_access?('user')
    assert !fred.role_access?('manager')
    assert !fred.role_access?('admin')
  end
  
  test "manager role limits" do
    molly = User.find_by_username("molly")
    assert molly.role?('manager')
    assert !molly.is_admin?
    assert molly.role_access?('guest')
    assert molly.role_access?('user')
    assert molly.role_access?('manager')
    assert !molly.role_access?('admin')
  end

  test "admin role limits" do
    admin = User.find_by_username("admin")
    assert admin.role?('admin')
    assert admin.is_admin?
    assert admin.role_access?('guest')
    assert admin.role_access?('user')
    assert admin.role_access?('manager')
    assert admin.role_access?('admin')
  end

end
