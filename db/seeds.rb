# Creates example categories:

Category.create!(
  name:  "Boarding"
)
Category.create!(
  name:  "Day Care"
)
Category.create!(
  name:  "Dog Beach"
)
Category.create!(
  name:  "Dog Park"
)
Category.create!(
  name:  "Groomer"
)
Category.create!(
  name:  "Pet Store"
)
Category.create!(
  name:  "Shelter"
)
Category.create!(
  name:  "Veterinarian"
)

categories = Category.all

puts "Seed finished"
puts "#{Category.count} categories created"