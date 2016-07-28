class TagTopic < ActiveRecord::Base
  validates :topic, inclusion: { in: %w(sports movies music news tv)}
  validates :topic, presence: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'Tagging'

  has_many :urls,
    through: :taggings,
    source: :shortened_url
end
