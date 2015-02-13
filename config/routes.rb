RedditClone::Application.routes.draw do
  resources :users
  resources :subs do
    resources :posts, only: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
  resource :posts, except: [:index]
end
