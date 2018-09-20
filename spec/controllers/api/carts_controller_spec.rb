require 'rails_helper'
require 'json'

RSpec.describe Api::CartsController, type: :controller do
  let!(:cart) { create :cart, products_count: 0 }

  describe 'GET cart' do
    it 'returns 200' do
      expect(get(:cart)).to have_http_status(200)
    end
  end
end
