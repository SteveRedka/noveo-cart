require 'rails_helper'
require 'json'

RSpec.describe Api::CartsController, type: :request do
  let!(:cart) { create :cart, products_count: 0 }
  let!(:product50) { create :product, price: 50 }
  let!(:product150) { create :product, price: 150 }

  describe 'GET cart' do
    before do
      2.times { cart.products << product50 }
      4.times { cart.products << product150 }
      get '/api/cart'
      @json_response = JSON.parse(response.body)
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
    it 'should add existing products' do
      expect do
        post('/api/cart', params: { product_id: product50.id, quantity: 4 })
      end.to change { cart.products.count }.by(4)
    end

    it 'should return error if product id is invalid' do
      post('/api/cart', params: { product_id: 'orange', quantity: 1 })
      expect(response.code).to eq '400'
    end

    it 'should return correct error (404) if product is not found' do
      post('/api/cart', params: { product_id: 999, quantity: 1 })
      expect(response.code).to eq '404'
    end

    it 'should not return any data' do
      post('/api/cart', params: { product_id: product50.id, quantity: 4 })
      expect(response.body).to eq ''
    end

    it 'should not permit more than 10 units posted at once' do
      post('/api/cart', params: { product_id: product50.id, quantity: 11 })
      expect(response.code).to eq '400'
    end
  end

  describe 'DELETE cart' do
    before do
      3.times { cart.products << product50 }
    end
    it 'should delete one product' do
      delete("/api/cart/#{product50.id}")
      expect(cart.products.count).to eq 2
    end

    it 'should delete product record upon reaching zero' do
      3.times do
        delete("/api/cart/#{product50.id}")
        sleep 0.1
      end
        sleep 0.1
      get '/api/cart'
      @json_response = JSON.parse(response.body)
      expect(@json_response['data']['products'].length).to eq 0
    end

    it 'should return error 404 if product id is absent from system' do
      delete("/api/cart/#{999}")
      expect(response.code).to eq '404'
    end

    it 'should return error 400 without parameter' do
      delete("/api/cart/")
      expect(response.code).to eq '400'
    end

    it 'should not return any data' do
      delete("/api/cart/#{product50.id}")
      expect(response.body).to eq ''
    end
  end
end
