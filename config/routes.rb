Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]

  resources :rooms

  
  root 'pages#index'

end
