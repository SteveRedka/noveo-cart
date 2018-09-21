class Cart < ApplicationRecord
  has_many :carts_products, class_name: 'CartsProduct'
  has_many :products, through: :carts_products

  def total_price
    result = 0
    products.each do |p|
      result += p.price
    end
    result
  end
end
