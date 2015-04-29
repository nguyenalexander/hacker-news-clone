class Post < ActiveRecord::Base
  belongs_to :user

  validates :title,
    presence: true,
    length: {minimum:10, maximum:100}

  validates :link,
    presence: true,
    length: {minimum:10, maximum: 255},
    format: { with: URI::regexp(%w(http https))}
end
