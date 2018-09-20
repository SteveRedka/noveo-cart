# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    transient do
      products_count 2
    end
    cookie 'foo'
    products { build_list :product, products_count }
  end
end
