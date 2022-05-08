Rails.application.routes.draw do

  resources :users, only: %i[new create]

  get '/rooms', to: 'rooms#index'
  root 'pages#index'

end
