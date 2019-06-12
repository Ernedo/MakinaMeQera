Rails.application.routes.draw do

  root 'pages#home'
  devise_for :users
  resources :clients, :cars, :reservations, :photos

  devise_scope :user do
    get '/profile', to: 'users#show', as: 'user'
    get '/profile/edit', to: 'users#edit', as: 'edit_user'
    put '/profile/update', to: 'users#update_profile', as: 'update_user'
  end


  namespace :admin do
    get '/users', to: 'users#index', as: 'users'
    post '/users', to: 'users#create', as: 'create_user'
    get '/users/new', to: 'users#new', as: 'new_user'
    get '/users/:id', to: 'users#show', as: 'user'
    delete '/users/:id', to: 'users#destroy', as: 'user_destroy'
  end

end
