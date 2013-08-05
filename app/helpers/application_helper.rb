module ApplicationHelper

  def active_tab tab
    return "active" if params[:controller] == tab
    return ""
  end

  def spinner_tag id
    #Assuming spinner image is called "spinner.gif"
    image_tag("spinner.gif", :id => id, :alt => t(:loading, :scope => 'myinfo.buttons'), :style => "display:none")
  end
  
  def title(page_title)
    content_for (:title) { page_title }
  end

  def yield_or_default(section, default = "")
    content_for?(section) ? content_for(section) : default
  end
  
  def avatar_url(user)
    if user.image_url.present?
      user.image_url
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?r=g&s=25&d=mm"
    end
  end

end
