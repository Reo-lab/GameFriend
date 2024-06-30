Rails.application.routes.draw do
  resources :boards
  devise_for :users
  get "/" => 'users#index'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
