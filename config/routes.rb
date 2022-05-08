Rails.application.routes.draw do

  get '/rooms', to: 'rooms#index'


  root 'pages#index'

end
