# require "resque_web"

Rails.application.routes.draw do

  mount ResqueWeb::Engine => "/resque_web"

  root 'pages#home'
  devise_for :users
  resources :clients, :cars, :reservations

  scope :photos do
    get '', to: "photos#index", as: "photos"
    get '/new', to: "photos#new", as: "new_photo"
    post '', to: "photos#create"

    delete '/destroy_multiple', to: "photos#destroy_multiple", as: "photos_destroy_multiple"
    post '/create_multiple', to: "photos#create_multiple", as: "photos_create_multiple"
    get '/new_create_multiple', to: "photos#new_create_multiple", as: "photos_new_create_multiple"

    get '/:id', to: "photos#show", as: "photo"
    get  '/:id/edit', to: "photos#edit", as: "edit_photo"
    put '/:id', to: "photos#update"
    patch '/:id', to: "photos#update"
    delete '/:id', to: "photos#destroy"
  end

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
