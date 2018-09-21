Rails.application.routes.draw do
  namespace :api do
    get '/products/', to: 'products#index'
    get '/cart/', to: 'carts#cart'
    post '/cart/', to: 'carts#add_product'
    delete '/cart/:product_id', to: 'carts#delete_product'
  end
end
