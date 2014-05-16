# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Actor.delete_all
Film.delete_all

file_names = Dir.entries("./lib/assets/films")
file_names.shift(2)
file_count = 0
file_total = file_names.count

file_names.each do |file_name|
  file_count += 1
  percent_complete = file_count.to_f / file_total
  rounded_percent_complete = (percent_complete * 1000).round / 1000.0
  puts "#{rounded_percent_complete}% seeded"

  json_text = File.read("./lib/assets/films/#{file_name}")
  json_hash = JSON.parse json_text
  film = Film.create(json_hash["film"])
  json_hash["cast"].each do |actor_hash|
    actor = Actor.find_or_create_by(actor_hash)
    film.actors << actor
  end
end