Rails.application.routes.draw do
  resources :likes
  post '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/home', to: 'home#display'
  root :to =>'sessions#welcome'
  resources :comments
  resources :post_tags
  resources :tags
  resources :posts
  resources :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
