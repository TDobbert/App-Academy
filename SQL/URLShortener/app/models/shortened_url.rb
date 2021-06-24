class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true
  validate :no_spamming, :nonpremium_max

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit,
    dependent: :destroy

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :users

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging,
    dependent: :destroy

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code
    new_short_url = SecureRandom.urlsafe_base64[0...16]
    while exists?(short_url: new_short_url)
      new_short_url = SecureRandom.urlsafe_base64[0...16]
    end
    new_short_url
  end

  def self.generate_short_url(user, long_url)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url,
                         short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    num_uniques.where("visits.created_at >= '#{10.minutes.ago}'")
  end

  def no_spamming
    last_minute = ShortenedUrl.where('created_at >= ?', 1.minute.ago)
                              .where(user_id: user_id)
                              .length

    errors[:maximum] << 'of five short urls per minute' if last_minute >= 5
  end

  def nonpremium_max
    return if User.find(user_id).premium

    max = ShortenedUrl.where(user_id: user_id).length
    return unless max >= 5

    errors[:Only] << 'premium members can create more than 5 short urls'
  end

  def prune
    ShortenedUrl
      .joins(:submitter)
      .joins('LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id')
      .where("(shortened_urls.id IN (
        SELECT shortened_urls.id
        FROM shortened_urls
        JOIN visits
        ON visits.shortened_url_id = shortened_urls.id
        GROUP BY shortened_urls.id
        HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
      ) OR (
        visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
      )) AND users.premium = \'f\'")
      .destroy_all
  end
end
