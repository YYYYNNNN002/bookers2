Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:update,:destroy]
  resources :books do
    resource :favorites, only: [:create,:destroy]
    resource :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]
  devise_for :users
  resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
