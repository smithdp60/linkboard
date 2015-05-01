class Post < ActiveRecord::Base

  belongs_to :user
  has_many :votes, as: :votable

  has_many :comments

  validates :title,
    presence: true,
    length: 10..100

  validates :link,
    presence: true,
    :url => true

end
