# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "a@a.com")
User.create!(email: "b@b.com")

ShortenedUrl.create_for_user_and_long_url!(User.first, 'www.google.com')
ShortenedUrl.create_for_user_and_long_url!(User.last, 'www.github.com')

Visit.create!({ user_id: 1, shortened_url_id: 1})
Visit.create!({ user_id: 2, shortened_url_id: 2})

TagTopic.create!({topic: 'sports'})
TagTopic.create!({topic: 'movies'})
TagTopic.create!({topic: 'tv'})

Tagging.create!({tag_topic_id: 1, url_id: 1})
Tagging.create!({tag_topic_id: 1, url_id: 2})
Tagging.create!({tag_topic_id: 2, url_id: 2})
