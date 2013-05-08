class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, #:recoverable, 
         :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :company, :provider, :uid
  # attr_accessible :title, :body

  validates_presence_of :name


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(:email => data["email"]).first
      unless user
          password = Devise.friendly_token[0,20]
          user = User.create(name: data["name"],
               email: data["email"],
               password: password,
               password_confirmation: password
              )
      end
      user
  end
end
