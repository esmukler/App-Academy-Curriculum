RedditClone::Application.routes.draw do
  resources :users
  resources :subs do
    resources :posts, only: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]
end
