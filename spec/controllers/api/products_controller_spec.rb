require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  describe 'GET products' do
    it 'returns 200' do
      expect(get(:index)).to have_http_status(200)
    end
  end
end
