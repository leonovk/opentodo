Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :edit, :update]

  resources :rooms, only: [:edit, :update, :index, :create, :show]

  resources :tasks, only: [:edit, :update]
  
  post "/rooms/:id", to: "tasks#create"
  post "/rooms/:id/add/", to: "rooms#add"
  delete "/rooms/:id/delete/", to: "rooms#destroy"
  post "/rooms/tasks/status/:id", to: "tasks#status"
  post "/", to: "tasks#create"
  get "/admin", to: "admins#index" 
  root 'pages#index'
  get "/faq", to: "pages#faq"
end
