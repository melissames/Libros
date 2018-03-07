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
  get '/discussion_and_book_search', to: 'discussions#search'
  get '/suggested_books', to: 'users#book_suggestion'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/user/:id/add_book', to: 'users#add_book', as: 'add_book'
  post '/user/:id/read_book', to: 'users#mark_as_read', as: 'read_book'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
