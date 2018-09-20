require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  let!(:products) { create_list(:product, 2) }

  describe 'GET products' do
    it 'returns 200' do
      expect(get(:index)).to have_http_status(200)
    end

    it 'returns 2 items' do
      json = JSON.parse(get(:index).body)
      expect(json.length).to eq(2)
    end
  end
end
