Rails.application.routes.draw do
  resources :gametitles
  resources :setups
  resources :boards
  devise_for :users
  resources :users
  get'/' => 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
