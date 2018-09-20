# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    description 'Product Description'
    price 50
  end
end
