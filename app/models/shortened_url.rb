require 'byebug'

class ShortenedUrl < ActiveRecord::Base
  validates(
    :short_url, :long_url, :user_id,
    presence: true
  )
  validates :short_url, uniqueness: true
  validates :long_url, length: { maximum: 255 }
  validate :not_spam

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many(
    :visitors,
      Proc.new { distinct },
      through: :visits,
      source: :user
  )

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: 'Tagging'

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def not_spam
    user = User.find(self.user_id)

    num_recent_submits = user.num_submits(1)
    if (num_recent_submits >= 5)
      self.errors[:shortenedUrl] << "Too many recent submissions, please slow down."
    end
  end

  def self.random_code
    code = nil
    while code.nil? || ShortenedUrl.exists?({ :short_url => code })
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({long_url: long_url, user_id: user.id, short_url: self.random_code})
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def recent_visits
    visits.select{ |visit| visit.created_at > 10.minutes.ago }
  end

  def num_recent_uniques
    recent_visits.map { |visit| visit.user_id }.uniq.count
  end

end
