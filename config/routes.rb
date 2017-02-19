Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resources :friendships, only: [:create]
  get "/friendships", to: "friendships#show", as: :show_friendships
  get "/friendships/common", to: "friendships#show_common", as: :show_common_friendships
  resources :subscriptions, only: [:create]
  get "/subscriptions", to: "subscriptions#show", as: :show_subscriptions
  resources :blockades, only: [:create]
end
