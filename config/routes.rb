Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create]

  resources :rooms, only: [:edit, :update]

  resources :tasks, only: [:edit, :update]
  

  get "/rooms", to: "rooms#index"
  post "/rooms", to: "rooms#create"
  get "/rooms/:id", to: "rooms#show", as: 'current_room'
  post "/rooms/:id", to: "tasks#create"
  post "/rooms/:id/add/", to: "rooms#add"
  delete "/rooms/:id/delete/", to: "rooms#destroy"
  ###

  ###
  post "/rooms/tasks/status/:id", to: "tasks#status"
  
  post "/", to: "tasks#create"
  get "/admin", to: "admins#index"
  
  root 'pages#index'

end
