Rails.application.routes.draw do
  namespace :api do
    resources :products
    get '/cart/', to: 'carts#cart'
    post '/cart/', to: 'carts#add_product'
    # post '/cart/', to: 'carts#add_product'
    # resources :carts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
