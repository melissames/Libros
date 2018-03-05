Rails.application.routes.draw do
  # resources :tags
  # resources :authors
  resources :comments, only: [:index, :show, :new, :create]
  resources :discussions, only: [:index, :show, :new, :create]
  resources :books, only: [:index, :show]
  resources :users

  root "users#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
