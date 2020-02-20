# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |_|
  title = Faker::Book.title
  body = Faker::Movie.quote
  Content.create(title: title, body: body, type: 'post')
end

50.times do |_|
  title = Faker::Book.genre
  body = Faker::Movie.quote
  author = Faker::Book.author
  source = Faker::Book.title
  Content.create(title: title, body: body, type: 'quote', author: author, source: source)
end
