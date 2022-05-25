# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
i=1
10.times do
  User.create(email: "jathp#{i}@yopmail.com", password: "123456", description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 10), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  i+=1
end

ActiveRecord::Base.connection.reset_pk_sequence!('events')
10.times do
  Event.create(start_date: Faker::Time.forward(days: 365), duration:300, title:Faker::Book.unique.title, description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 10), price: 120, location: Faker::Space.planet, admin: User.find(rand(User.first.id..User.last.id)))
end

ActiveRecord::Base.connection.reset_pk_sequence!('attendances')
 25.times do
  Attendance.create(strip_customer_id: Faker::Number.unique.number(digits: 10), event: Event.find(rand(Event.first.id..Event.last.id)), attendee: User.find(rand(User.first.id..User.last.id)))
end
