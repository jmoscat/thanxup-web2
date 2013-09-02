class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :recoverable,  :confirmable, :omniauthable
  
  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  field :username,             :type => String, :default=> ""
  field :role,                 :type => String, :default=> "guest"
  field :provider,             :type => String
  field :uid,                  :type => String
  field :image_url,            :type => String

  index({ confirmation_token: 1}, { unique: true, background: true })
  index({ email: 1 }, { unique: true, background: true })
  index({ reset_password_token: 1 }, { unique: true, background: true })
  index({ username: 1 }, { unique: true, background: true })
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role, :image_url
  
  # /DEVISE and OmniAuth
  
  validates :username, :uniqueness => true, :length => { :within => 4..12 }
  has_many :venues
  accepts_nested_attributes_for :venues


  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first_or_create do |new_user|
      new_user.provider = auth.provider
      new_user.uid = auth.uid
      new_user.username = auth.info.nickname
    end
    user.image_url = auth.info.image # need to update in case image changed on provider's site
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  #def email_required?
    #false
  #end
  
  def self.user_exists_but_email_is_unconfirmed?(username)
    user = User.find_by(username: username)
    return user.email_unconfirmed? if user
    false
  end
  
  def email_unconfirmed?
    (!self.email.blank? && !self.confirmed?) || !self.unconfirmed_email.blank?
  end
  
  def self.fetch_email(username)
    user = self.find_by(username: username) if username
    user.email if user
  end

  def self.fetch_unconfirmed_email(username)
    user = self.find_by(username: username) if username
    (user.unconfirmed_email.blank? ? user.email : user.unconfirmed_email) if user
  end

  # handle roles
  
  def self.user_role; "user"; end
  def self.admin_role; "admin"; end
  def self.guest_role; "guest"; end
  def self.manager_role; "manager"; end

  def self.role_collection
    [['guest', 'guest'],['user','user'],['manager','manager']]
  end
  
  def self.role_collection_with_admin
    [['guest', 'guest'],['user','user'],['manager','manager'],['admin','admin']]
  end

  def role?(role)
    return true if role == 'admin' && self.role == 'admin'
    return true if role == 'manager' && self.role == 'manager'
    return true if role == 'user' && self.role == 'user'
    return true if role == 'guest' && ( self.role.nil? || self.role == 'guest')
  end

  def valid_role?(role)
    ['guest','user', 'manager', 'admin'].include?(role)
  end
 
  def is_admin?
    self.role == 'admin'
  end
 
  def role_access?(role)
    return false if (role.nil? || self.role.nil? || !valid_role?(self.role))
    return true if role == 'guest'
    return true if role == 'admin' && self.role == 'admin'
    return true if role == 'manager' && ['manager', 'admin'].include?(self.role)
    return true if role == 'user' && ['user', 'manager', 'admin'].include?(self.role)
    return false
  end


end
