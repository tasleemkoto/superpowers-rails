# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'date'

Booking.destroy_all
Superpower.destroy_all
User.destroy_all


# Users Seeds
15.times do
  User.create!(
    username: Faker::Internet.username(specifier: 5..10),
    email: Faker::Internet.email,
    password: "password"
  )
end

superpowers = [
  { title: "Super Strength", description: "Extraordinary physical power.", category: "Physical" },
  { title: "Super Speed", description: "Ability to move at incredibly high speeds.", category: "Physical" },
  { title: "Enhanced Agility", description: "Exceptional reflexes and balance.", category: "Physical" },
  { title: "Invulnerability", description: "Immunity to physical damage.", category: "Physical" },
  { title: "Regeneration", description: "Ability to heal rapidly from injuries.", category: "Physical" },
  { title: "Elasticity", description: "Stretch and reshape the body at will.", category: "Physical" },
  { title: "Density Control", description: "Become intangible or extremely dense.", category: "Physical" },
  { title: "Endurance", description: "Resist fatigue and exhaustion.", category: "Physical" },
  { title: "Size Manipulation", description: "Grow or shrink in size.", category: "Physical" },
  { title: "Wall Crawling", description: "Stick to walls and ceilings.", category: "Physical" },

  # Mental and Sensory Powers
  { title: "Telepathy", description: "Communicate or read others' thoughts.", category: "Mental" },
  { title: "Mind Control", description: "Influence others’ actions or thoughts.", category: "Mental" },
  { title: "Precognition", description: "See events before they happen.", category: "Mental" },
  { title: "Memory Manipulation", description: "Access or alter memories.", category: "Mental" },
  { title: "Enhanced Senses", description: "Superhuman vision, hearing, smell, etc.", category: "Sensory" },
  { title: "Psychometry", description: "Read the history of objects by touch.", category: "Sensory" },
  { title: "Empathy", description: "Sense and influence emotions.", category: "Mental" },
  { title: "Clairvoyance", description: "See distant events or places.", category: "Sensory" },
  { title: "Intuitive Aptitude", description: "Instantly understand complex subjects.", category: "Mental" },
  { title: "Hypnosis", description: "Control the subconscious of others.", category: "Mental" }
]

# Loop to create each superpower entry
superpowers.each do |power|
  Superpower.create!(
    title: power[:title],
    user: User.all.sample,
    description: power[:description],
    category: power[:category],
    selling_price: rand(500..1000), # Optional: add a price for variety
    renting_price: rand(100..300) # Optional: add a price for variety
  )
end

# loop: create fake bookings
15.times do
  Booking.create(
    user: User.all.sample,
    start_date: Date.today,
    end_date: Date.today,
    superpower: Superpower.all.sample
  )
end
