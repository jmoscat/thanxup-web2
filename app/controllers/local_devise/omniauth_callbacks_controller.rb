class LocalDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    if auth.valid? 
      user = User.from_omniauth(auth)
      if user.persisted? && user.confirmed? && user.unconfirmed_email.blank?
        user.role = 'user' if user.role?('guest')
        flash.notice = t(:signed_in, :scope => 'devise.sessions')
        log_sign_in user
        sign_in(user)
        redirect_to(request.env['omniauth.origin'] || root_path)
      else
        redirect_after_auth_failure(user)
      end
    else
       redirect_after_auth_failure
    end
  end
  alias_method :twitter, :all

  private

  def  redirect_after_auth_failure(user=nil)
    if user
      if user.email_unconfirmed?
        flash.notice = t(:signed_up_but_inactive_html, :scope => 'myinfo.devise.failure', 
                  :resend_link => view_context.link_to(t(:resend_confirmation_email_link_text, :scope => 'myinfo.devise.failure'), new_user_confirmation_path))
        redirect_to(request.env['omniauth.origin'] || root_path)      
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end            
    else
      Rails.logger.info "*** TWITTER API FAIL ***"
      Rails.logger.debug "*** #{request.env["omniauth.auth"]['extra']['raw_info'].to_json}"
      flash.notice = t(:unable_to_sign_in_to_twitter, :scope => 'devise.failure')
      redirect_to(request.env['omniauth.origin'] || root_path)      
    end
  end
end
