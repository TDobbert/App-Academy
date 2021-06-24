class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    class_name: :Visit,
    foreign_key: :user_id,
    primary_key: :id

  has_many :visited_urls,
    # scope block to remove duplicates
    Proc.new { distinct },
    through: :visits,
    source: :shortened_urls
end
