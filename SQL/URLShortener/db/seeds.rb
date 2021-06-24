# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  u1 = User.create!(email: 'aang@gmail.com', premium: true)
  u2 = User.create!(email: 'sakka@gmail.com')

  su1 = ShortenedUrl.generate_short_url(u1, 'www.facebook.com')
  su2 = ShortenedUrl.generate_short_url(u2, 'www.instagram.com')
  su3 = ShortenedUrl.generate_short_url(u2, 'www.netflix.com')

  Visit.record_visit!(u1, su1)
  Visit.record_visit!(u1, su1)
  Visit.record_visit!(u1, su2)

  Visit.record_visit!(u2, su2)
  Visit.record_visit!(u2, su2)
  Visit.record_visit!(u2, su1)
  Visit.record_visit!(u2, su3)

  tt1 = TagTopic.create!(name: 'Social Media')
  tt2 = TagTopic.create!(name: 'Streaming')

  Tagging.create!(shortened_url: su1, tag_topic: tt1)
  Tagging.create!(shortened_url: su2, tag_topic: tt1)
  Tagging.create!(shortened_url: su3, tag_topic: tt2)
end
