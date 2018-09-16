Rails.application.routes.draw do
	root 'static_pages#home'
  get '/about', 			  to: 'static_pages#about'
  get '/contact', 		  to: 'static_pages#contact'
  get '/help', 				  to: 'static_pages#help'
  get '/signup',  		  to: 'users#new'
  post '/signup',			  to: 'users#create'
  get '/login',				  to: 'sessions#new'
  post '/login',			  to: 'sessions#create'
  delete '/logout',		  to: 'sessions#destroy'
  post 'chirps/new',    to: 'chirps#new',           as: :post

  resources :users do 
    member do
      get :following, :followers, :liked_chirps
    end
  end
  resources :chirps do
    get 'chirps/edit',  to: 'chirps#edit',          as: :patch
    # get 'chirps/show',  to: 'chirps#show',          as: :get
    member do
      put 'like',       to: "chirps#like"
      put 'unlike',     to: "chirps#unlike"
      post 'reply',     to: "chirps#reply"
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end
