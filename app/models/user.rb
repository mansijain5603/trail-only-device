class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :validatable, 
         authentication_keys: [:login] 
  

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #   unless user
  #     user = User.create(
  #       email: data['email'],
  #       password: Devise.friendly_token[0,20]
  #     )
  #       end
  #     user
  #   end

  def login
    @login || self.username || self.email || self.mobile
  end
  
  def email_required?
    false
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(mobile) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:mobile)
      where(conditions.to_h).first
    end
  end
end