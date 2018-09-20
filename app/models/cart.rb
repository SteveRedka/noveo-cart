class Cart < ApplicationRecord
  has_and_belongs_to_many :products

  def total_price
    result = 0
    products.each do |p|
      result += p.price
    end
    result
  end
end
