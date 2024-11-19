# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# create 10 users

USER_INSTANCES = 10

def seed_users
  USER_INSTANCES.times do |i|
    User.create!(email: Faker::Internet.email, password: "password")
  end
  puts "Created #{USER_INSTANCES} users"
end

def follow_request
  odd_users = User.where("id % 2 = 1")
  even_users = User.where("id % 2 = 0")
  odd_users.each_with_index do |user, i|
    user.follow_requests.create(leader_id: i + 1)
  end
  puts "Created follow requests. odd users follow even users"
end
