Rails.application.routes.draw do
	root 'static_pages#home'
  get '/about', 			to: 'static_pages#about'
  get '/contact', 		to: 'static_pages#contact'
  get '/help', 				to: 'static_pages#help'
  get '/signup',  		to: 'users#new'
  post '/signup',			to: 'users#create'
  get '/login',				to: 'sessions#new'
  post '/login',			to: 'sessions#create'
  delete '/logout',		to: 'sessions#destroy'

  resources :users do 
    member do
      get :following, :followers
    end
  end
  resources :chirps do
    member do
      put 'like',   to: "chirps#like"
      put 'unlike', to: "chirps#unlike"
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :chirps,              only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
