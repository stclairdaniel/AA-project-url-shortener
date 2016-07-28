class User < ActiveRecord::Base
  validates(
    :email,
    uniqueness: true,
    presence: true
    )

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many(
    :visited_urls,
      Proc.new { distinct },
      through: :visits,
      source: :shortened_url
  )

  def submit_url!(long_url)
    ShortenedUrl.create_for_user_and_long_url!(self, long_url)
  end

  def visit_url!(short_url_string)
    short_url = ShortenedUrl.find_by({short_url: short_url_string})
    raise "No URL found" if short_url.nil?
    Visit.record_visit!(self, short_url)
  end

  def num_submits(within_minutes = nil)
    return submitted_urls.count if within_minutes.nil?

    where_clause = "created_at > '#{within_minutes.minutes.ago}'"
    where_clause += " AND user_id = #{self.id}"
    ShortenedUrl.where(where_clause).count
  end

end
