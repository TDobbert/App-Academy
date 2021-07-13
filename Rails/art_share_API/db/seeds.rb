# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: 'Tom')
User.create!(username: 'Erica')
User.create!(username: 'Bill')
User.create!(username: 'Jess')

Artwork.create!(title: 'The Starry Night', image_url: 'imgur.com/starry_night', artist_id: 1)
Artwork.create!(title: 'The Last Supper', image_url: 'imgur.com/last_supper', artist_id: 2)
Artwork.create!(title: 'Mona Lisa', image_url: 'imgur.com/mona_lisa', artist_id: 2)
Artwork.create!(title: 'Guernica', image_url: 'imgur.com/guernica', artist_id: 4)
Artwork.create!(title: 'The Kiss', image_url: 'imgur.com/the_kiss', artist_id: 3)

ArtworkShare.create!(artwork_id: 1, viewer_id: 1)
ArtworkShare.create!(artwork_id: 2, viewer_id: 1)
ArtworkShare.create!(artwork_id: 3, viewer_id: 4)
ArtworkShare.create!(artwork_id: 4, viewer_id: 2)
ArtworkShare.create!(artwork_id: 5, viewer_id: 3)
