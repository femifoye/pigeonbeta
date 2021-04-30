Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  resources :items
  resources :users

  # designate a root page
  root 'pages#home'
  # route to checkout page
  get '/checkout', to: 'pages#checkout'
  # route to empty cart
  get '/empty-cart', to: 'carts#empty'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
