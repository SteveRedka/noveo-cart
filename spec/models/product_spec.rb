require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should be able to be in many carts' do
    create_list :cart, 2
    product = create :product
    Cart.first.products << product
    Cart.last.products << product
    expect(product.carts.length).to eq 2
  end
end
