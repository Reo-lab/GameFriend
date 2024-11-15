# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :chatrooms, only: %i[index show new create destroy] do
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

    resources :boards_requests, only: %i[new create] do
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

  resources :boards_requests, only: %i[index show destroy]
  get 'request_index' => 'boards_requests#request_index'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users do
    resources :users_slides
  end
  resources :slide_images do
    member do
      get 'change'
      patch 'change'
    end
  end
  resources :tops
  root 'tops#index'

  post 'sessions', to: 'sessions#create'
  get 'users/:id/icon', to: 'users#icon'

  resources :helper_images
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
