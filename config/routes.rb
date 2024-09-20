Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :chatrooms, only: [:index, :show, :new, :create, :destroy] do
    resources :messages, only: [:create]
    member do
      get 'user_add'
      get 'remove_users'
      post 'remove_users'
      get 'add_users'
      post 'add_users'
    end
  end

  resources :gametitles
  resources :setups
  resources :boards do
    member do
      post 'toggle_openchanger'
    end
    
    resources :boards_requests, only: [:new, :create] do
      member do
        post 'approve'
      end
    end
  end
  resources :notifications do
    collection do
      patch 'mark_all_as_read'
      get 'unread_count'
    end
  end
  # 通知を取得するためのエンドポイント

  resources :boards_requests, only: [:index, :show, :destroy]
  get 'request_index' => 'boards_requests#request_index'
  devise_for :users
  resources :users
  resources :tops
  root 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
