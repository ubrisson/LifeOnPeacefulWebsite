Rails.application.routes.draw do
  get '/quotes/export'
  post '/quotes/import'
  resources :quotes
  get 'contents/new'
  get '/posts', to: 'contents#posts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/resources/export'
  post '/resources/import'
  resources :resources, except: [:new]
end
