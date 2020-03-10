Rails.application.routes.draw do
  get '/index', to: 'content_pages#index'
  get '/latest', to: 'content_pages#latest'
  get '/quotes/export'
  post '/quotes/import'
  resources :quotes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/resume', to: 'static_pages#resume'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/resources/export'
  post '/resources/import'
  resources :resources, except: [:new]
  get '/posts/export'
  post '/posts/import'
  resources :posts
  resources :comments, only: [:create, :update, :destroy]
end
