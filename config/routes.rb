Rails.application.routes.draw do
  get 'gametitles/index'
  get 'gametitles/show'
  get 'gametitles/edit'
  get 'gametitles/new'
  get 'gametitles/update'
  get 'gametitles/destroy'
  resources :setups
  resources :boards
  devise_for :users
  resources :users
  get'/' => 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
