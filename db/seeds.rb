# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Like.destroy_all
User.destroy_all
Review.destroy_all
Idea.destroy_all

PASSWORD = "123"

5.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}@#{last_name.downcase}.com",
    password: PASSWORD
  )
end

users = User.all

until Idea.all.count == 20
  created_at = Faker::Date.backward(days:365 * 2)

  i = Idea.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::Lorem.paragraph * 5,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )

  if i.valid?
    rand(1..5).times do
      r = Review.create(
        body: Faker::Lorem.paragraph * 3,
        idea: i,
        user: users.sample
      )
    end
  end

  i.likers = users.shuffle.slice(0, rand(users.count))
end

ideas = Idea.all
reviews = Review.all

puts reviews.count
puts ideas.count
puts users.count