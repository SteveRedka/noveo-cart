require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'should be able to have many products' do
    cart = create :cart, products_count: 4
    expect(cart.products.count).to eq 4
  end
end
