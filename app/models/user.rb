#Authentication portion from: http://railscasts.com/episodes/250-authentication-from-scratch

class User < ActiveRecord::Base
  # Each User has many notes. When a user account is deleted, all associated notes are deleted as well. 
  has_many :notes, dependent: :destroy
  attr_accessor :password
  before_save :encrypt_password
  
  # Each email and username must be unique
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
  
  # Function to authenticate user with their email and password
  def self.authenticate(email, password)
    user = find_by(email: email)
    logger.info "#{user}"
    # Check salted password hash is correct
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  # Function to generate a salted hash of the user's password using BCrypt
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

