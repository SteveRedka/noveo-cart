# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot'

cart = Cart.create(
  cookie: 'foo'
)

2.times do |i|
  product = Product.create(
    name: "Product #{i + 1}",
    description: 'Product Description',
    price: 50 + (i * 100)
  )
  cart.products << product
end


