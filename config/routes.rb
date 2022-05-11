Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]

  get "/rooms", to: "rooms#index"
  post "/rooms", to: "rooms#create"
  get "/rooms/:id", to: "rooms#show", as: 'current_room'
  post "/rooms/:id", to: "tasks#create"
  delete "/tasks/:id", to: "tasks#destroy"
  
  root 'pages#index'

end
