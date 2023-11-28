Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'main#index'

  # devise
  devise_for :users
  resources :users, only: [:show]
  resources :categories
  resources :recipes do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end


  # user
  get '/users/:id', to: 'users#show', as: 'user_profile'
  get '/users/:id/recipes', to: 'users#recipes', as: 'user_profile_recipes'

  # private pages
  get 'myrecipes', to: 'users#my_recipes', as: 'my_recipes'
  get 'favorites', to: 'users#favorites', as: 'favorites'
  
  # search
  get '/search', to: 'search#search', as: 'search'

  # videos
  get "/videos/:id", to: "videos#show", as: "video"
  get '/cookbook', to: "main#cookbook", as: "cookbook"
  # admin panel
  namespace :admin do
    root 'dashboard#index'
    resources :users
    resources :categories
    resources :recipes do
      member do
        post :publish
      end
    end
    resources :comments do
      member do
        post :publish
      end
    end
  end
end
