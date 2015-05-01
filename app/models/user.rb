class User < ActiveRecord::Base

  has_secure_password

  #posts created by user
  has_many :posts

  #posts about this user
  has_many :votes, as: :votable

  #posts cast by user (via user_id foreign key)
  has_many :ratings, class_name: 'Vote'

  has_many :comments

  validates :name,
    presence: true,
    length: { maximum: 20 }

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :password,
    presence: true,
    :on => :create

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
