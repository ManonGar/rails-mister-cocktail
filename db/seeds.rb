# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

puts 'Cleaning database...'
Ingredient.destroy_all
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
uri = URI(url)
response = Net::HTTP.get(uri)
drinks = JSON.parse(response)
puts 'Creating ingredients...'
drinks['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
  puts "Created #{ingredient['strIngredient1']}"
end

puts 'Creating cocktails...'
5.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  cocktail = JSON.parse(response)
  Cocktail.create(name: cocktail['drinks'][0]['strDrink'])
  puts "Created #{cocktail['drinks'][0]['strDrink']}"
end
