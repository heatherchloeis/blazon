Rails.application.routes.draw do
  get 'notifications/link_through'
	root 'static_pages#home'
  get '/about', 			  to: 'static_pages#about'
  get '/help',          to: 'static_pages#help'
  get '/developer', 		to: 'static_pages#developer'
  get '/terms',         to: 'static_pages#terms'
  get '/cookies',       to: 'static_pages#cookies'
  get '/signup',  		  to: 'users#new'
  post '/signup',			  to: 'users#create'
  get '/login',				  to: 'sessions#new'
  post '/login',			  to: 'sessions#create'
  delete '/logout',		  to: 'sessions#destroy'
  get :search,          controller: :application

  resources :users do 
    member do
      get :following, :followers, :liked_posts
    end
  end
  resources :posts do
    get 'posts/edit',  to: 'posts#edit',          as: :patch
    get 'posts/show',  to: 'posts#show'
    member do
      put 'like',       to: "posts#like"
      put 'unlike',     to: "posts#unlike"
      get 'reply',      to: "posts#reply",         as: 'reply'
      get 'repost',    to: "posts#repost",       as: 'repost'
      post 'modal_create',    to: 'posts#modal_create',     as: 'modal_create'
    end
  end
  resources :conversations do
    resources :messages
  end
  resources :notifications do
    get 'link_through', to: "notifications#link_through",    as: 'link_through'
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]

  get 'mentions',       to: "users#mentions"
end