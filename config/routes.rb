Rails.application.routes.draw do
  resources :users do
    resources :goals, only: [ :new ]
  end
  resource :session
  resources :goals, except: [ :new ]
end
