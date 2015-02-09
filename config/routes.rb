Rails.application.routes.draw do
  #resources :users

  get '/users' => 'users#index'
  post '/users' => 'users#create'
  get '/users' => 'users#new', :as => 'new_user'
  get '/users/:id/edit' => 'users#edit', :as => 'edit_user'
  get '/users/:id' => 'users#show', :as => 'user'
  put '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'




end
