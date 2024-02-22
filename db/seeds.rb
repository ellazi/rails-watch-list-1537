require 'json'
require 'open-uri'
require 'faker'

# Clean database
puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

# Creating movies
puts "Creating movies..."

response = URI.open 'http://tmdb.lewagon.com/movie/top_rated?'
movies = JSON.parse(response.read)

movies["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

# 10.times do |movie|
#   movie = Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.paragraphs(number: 2).join("\n"),
#     poster_url: Faker::Internet.url,
#     rating: rand(1.0..10.0).round(1)
#   )
#   movie.save!
# end

puts "Movies created!"

# Creating lists
puts "Creates lists..."

10.times do |list|
  list = List.create(
    name: Faker::Book.title,
  )
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
