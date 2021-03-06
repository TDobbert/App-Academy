class Artwork < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist_id }
  validates :artist_id, presence: true
  validates :image_url, presence: true, uniqueness: true

  belongs_to :artist,
  primary_key: :id,
  foreign_key: :artist_id,
  class_name: :User

  has_many :shared_viewers,
  through: :artwork_shares,
  source: :viewer

  has_many :comments,
  dependent: :destroy
end
