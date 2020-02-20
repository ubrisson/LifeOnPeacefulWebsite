Rails.application.routes.draw do
  get 'contents/new'
  get '/posts', to: 'contents#posts'
  get '/quotes', to: 'contents#quotes'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/resources', to: 'static_pages#resources'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
