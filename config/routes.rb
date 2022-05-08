Rails.application.routes.draw do

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  get '/rooms', to: 'rooms#index'
  root 'pages#index'

end
