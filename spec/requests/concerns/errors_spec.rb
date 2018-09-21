require 'rails_helper'
require 'json'

RSpec.describe Api::CartsController, type: :request do
  describe '400' do
    it 'should handle bad requests properly' do
      post('/api/cart')
      expect(response.status).to eq(400)
      expect(response.body).to include('invalid_param_error')
    end
  end

  describe '404' do
    it 'should render Not Found errors correctly' do
      get '/api/info'
      expect(response.status).to eq(404)
      expect(response.body).to include('Unable to resolve the request')
    end
  end
end
