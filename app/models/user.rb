class User < ActiveRecord::Base

  has_secure_password

  has_many :posts

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :password,
    presence: true,
    :on => :create

  validates :name,
    presence: true,
    length: {maximum: 25}

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end


end
