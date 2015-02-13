RedditClone::Application.routes.draw do
  resources :users
  resources :subs
  resource :session, only: [:new, :create, :destroy]
end
