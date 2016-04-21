# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

10.times do
  user = User.new(
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(8)
  )
  user.save!
end

users = User.all


50.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Hipster.paragraph
  )
end

wikis = Wiki.all

puts "Seeds Finished!"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
