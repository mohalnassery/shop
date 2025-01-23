# Clean existing data
puts "Cleaning database..."
Product.destroy_all
Category.destroy_all
User.destroy_all

# Create categories
puts "Creating categories..."
categories = {}
["Electronics", "Vehicles", "Fashion", "Watches", "Musical Instruments", 
 "Computers", "Home & Garden", "Sports", "Books", "Others"].each do |name|
  categories[name.downcase.gsub(' & ', '_').gsub(' ', '_').to_sym] = Category.create!(name: name)
end

# Create users
puts "Creating users..."
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  name: 'Admin User'
)

user = User.create!(
  email: 'user@example.com',
  password: 'password123',
  name: 'Test User'
)

# Create products
puts "Creating products..."
[
  {
    title: "Gaming Laptop",
    description: "High-performance gaming laptop with RTX 3080",
    price: 2499.99,
    brand: "Lenovo",
    model: "Legion Pro",
    condition: "New",
    finish: "Black",
    user: admin,
    category: categories[:computers]
  },
  {
    title: "Ferrari F430",
    description: "Beautiful Ferrari F430 in excellent condition",
    price: 89999.99,
    brand: "Ferrari",
    model: "F430",
    condition: "Used",
    finish: "Red",
    user: admin,
    category: categories[:vehicles]
  },
  {
    title: "Opel Astra",
    description: "Reliable family car in good condition",
    price: 15999.99,
    brand: "Opel",
    model: "Astra",
    condition: "Used",
    finish: "Silver",
    user: user,
    category: categories[:vehicles]
  },
  {
    title: "Fossil Watch",
    description: "Elegant Fossil watch with leather strap",
    price: 199.99,
    brand: "Fossil",
    model: "FS5241",
    condition: "New",
    finish: "Brown",
    user: user,
    category: categories[:watches]
  },
  {
    title: "Fender Stratocaster",
    description: "Classic electric guitar in mint condition",
    price: 899.99,
    brand: "Fender",
    model: "Stratocaster",
    condition: "New",
    finish: "Sunburst",
    user: admin,
    category: categories[:musical_instruments]
  }
].each do |product_data|
  Product.create!(product_data)
end

puts "Seeding completed!"
puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"
puts "Created #{User.count} users"
