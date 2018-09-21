class Product < ApplicationRecord
  has_many :carts_products, class_name: 'CartsProduct'
  has_many :carts, through: :carts_products
end
