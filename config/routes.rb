Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :clients, :cars, :reservations
  namespace :admin do
    get '/users', to: 'users#index', as: 'users'
    get '/users/:id', to: 'users#show', as: 'user'
    get '/users/new', to: 'users#new', as: 'new_user'
    delete '/users/:id', to: 'users#destroy', as: 'user_destroy'
  end
end
