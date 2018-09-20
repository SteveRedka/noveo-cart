require 'rails_helper'
require 'json'

RSpec.describe Api::CartsController, type: :controller do
  let!(:cart) { create :cart, products_count: 0 }
  let!(:product50) { create :product, price: 50 }
  let!(:product150) { create :product, price: 150 }

  describe 'GET cart' do
    before do
      2.times { cart.products << product50 }
      4.times { cart.products << product150 }
      @json_response = JSON.parse(get(:cart).body)
    end

    it 'returns 200' do
      expect(get(:cart)).to have_http_status(200)
    end

    it 'counts monetary sum of products in cart' do
      expect(@json_response['data']['total_sum']).to eq 700
    end

    it 'counts amount of each product' do
      expect(@json_response['data']['products'][0]['quantity']).to eq 2
      expect(@json_response['data']['products'][1]['quantity']).to eq 4
    end

    it 'counts total price of each product' do
      expect(@json_response['data']['products'][0]['sum']).to eq 100
      expect(@json_response['data']['products'][1]['sum']).to eq 600
    end
  end

  describe 'POST cart' do
    it 'should add existing products'

    it 'should return error if product id is invalid'

    it 'should return error if product quantity is invalid'

    it 'should not return any data'

    it 'should not permit more than 10 units posted at once'
  end

  describe 'DELETE cart' do
    it 'should delete one product'

    it 'should delete product record upon reaching zero'

    it 'should return error 400 if product id is absent from system'

    it 'should not return any data'
  end
end