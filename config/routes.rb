Rails.application.routes.draw do
  resources :tags, only: [:new, :create]
  # resources :authors
  resources :comments, only: [:index, :show, :new, :create]
  resources :discussions, only: [:index, :show, :new, :create]
  resources :books, only: [:index, :show]
  resources :users

  root "users#home"
  get '/search', to: 'books#search'
  get '/tag_search', to: 'books#tag_search'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
