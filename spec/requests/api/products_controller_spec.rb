require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
  let!(:products) { create_list(:product, 2) }

  describe 'GET products' do
    it 'returns 2 items' do
      get('/api/products')
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end
end
