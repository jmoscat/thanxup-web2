class LocalDevise::SessionsController < Devise::SessionsController
  def create
  
    if User.user_exists_but_email_is_unconfirmed?(params[:user][:username])
      set_msg t(:signed_up_but_inactive_html, :scope => 'myinfo.devise.failure', 
                  :resend_link => view_context.link_to(t(:resend_confirmation_email_link_text, :scope => 'myinfo.devise.failure'), new_user_confirmation_path))
    else
      self.resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failed_login")
      sign_in(resource_name, resource)   
      set_msg t(:signed_in, :scope => 'devise.sessions')
      log_sign_in
    end
    respond_to do |format|
      format.js
      # and now keep placeholder integration test happy
      format.html {render :nothing => true, :status => 200, :content_type => 'text/html'}
    end
  end

  def failed_login
    set_msg t(:invalid, :scope => 'devise.failure')   
  end
end
