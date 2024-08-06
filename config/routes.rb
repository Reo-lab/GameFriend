Rails.application.routes.draw do
  resources :chatrooms, only: [:index, :show, :new, :create, :destroy] do
    resources :messages, only: [:create]
    member do
      get 'add_users'
      post 'add_users'
    end
  end

  resources :gametitles
  resources :setups
  resources :boards do
    resources :boards_requests, only: [:new, :create] do
      member do
        post 'approve'
      end
    end
  end
  resources :boards_requests, only: [:index, :show]
  devise_for :users
  resources :users
  resources :tops
  get'/' => 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
