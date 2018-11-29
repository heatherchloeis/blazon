Rails.application.routes.draw do
  get 'notifications/link_through'
	root 'static_pages#home'
  get '/about', 			  to: 'static_pages#about'
  get '/contact', 		  to: 'static_pages#contact'
  get '/help', 				  to: 'static_pages#help'
  get '/signup',  		  to: 'users#new'
  post '/signup',			  to: 'users#create'
  get '/login',				  to: 'sessions#new'
  post '/login',			  to: 'sessions#create'
  delete '/logout',		  to: 'sessions#destroy'
  get :search,          controller: :application

  resources :users do 
    member do
      get :following, :followers, :liked_chirps
    end
  end
  resources :chirps do
    get 'chirps/edit',  to: 'chirps#edit',          as: :patch
    get 'chirps/show',  to: 'chirps#show'
    member do
      put 'like',       to: "chirps#like"
      put 'unlike',     to: "chirps#unlike"
      get 'reply',      to: "chirps#reply",         as: 'reply'
      get 'rechirp',    to: "chirps#rechirp",       as: 'rechirp'
      post 'modal_create',    to: 'chirps#modal_create',     as: 'modal_create'
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