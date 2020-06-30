Rails.application.routes.draw do
  resources :comments
  resources :post_tags
  resources :tags
  resources :posts
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/home', to: 'home#display'
  post '/logout', to: 'sessions#destroy'
  root :to =>'sessions#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
