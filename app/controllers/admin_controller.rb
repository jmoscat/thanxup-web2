class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter do |c|
    c.send(:check_access_level, User.manager_role)
  end
  
  def index
    @users = User.all.sort(role: 1,username:1)
  end
  
  def add_new_user
    if (params[:user] and params[:user][:venue])
      pwd = SecureRandom.hex(4) # user will need to use the "forgot password" feature to set a useful password
      options = {:username => params[:user][:username], :email => params[:user][:email], :password => pwd, :password_confirmation => pwd, :role => User.user_role} if params[:user]
      user = User.new(options)
      user.thanx = pwd
      user.venues.push(Venue.new(venue_thnx_id: params[:user][:venue][:venue_thnx_id]))
      unless (user.save)
        @error_message = user.errors.full_messages.map{|s| s}.join('<br />') if user.errors
        @error_message ||= t(:cannot_save_new_user, :scope => 'myinfo.errors.messages')
      end
    else
      @error_message ||= t(:cannot_save_new_user, :scope => 'myinfo.errors.messages')
    end
    @users = User.all.sort(role: 1,username:1)
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render :layout=>false }
    end
  end
  
  def update_user
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { respond_with_bip(@user) }
    end
  end

  def delete_user   
    @user = User.find(params[:id])
    @user.destroy if current_user.is_admin?
    @users = User.all.sort(role: 1,username:1)
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render :layout=>false }
    end
  end
  
end
