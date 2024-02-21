# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Clean database
puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

# Creating movies
puts "Creating movies..."

10.times do |movie|
  movie = Movie.create(
    title: Faker::Movie.title,
    overview: Faker::Lorem.paragraphs(number: 2).join("\n"),
    poster_url: Faker::Internet.url,
    rating: rand(1.0..10.0).round(1)
  )
  movie.save!
end

puts "Movies created!"

# Creating lists
puts "Creates lists..."

5.times do |list|
  list = List.create(
    name: Faker::Book.title,
  )
  list.save!
end

puts "Lists created!"

# Creating bookmarks
puts "Creating bookmarks..."

Movie.all.each do |movie|
  bookmark = Bookmark.create(
    comment: Faker::Quote.yoda,
    movie_id: movie.id,
    list_id: List.all.sample.id
  )
  bookmark.save!
end

puts "Bookmarks created!"
