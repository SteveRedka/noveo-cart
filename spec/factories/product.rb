# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    description 'Product Description'
    sequence(:price) { |n| 50 + n * 100 }
  end
end
