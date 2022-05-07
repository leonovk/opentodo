Rails.application.routes.draw do

  get '/tasks', to: 'tasks#index'
  post '/tasks', to: 'tasks#new'
  delete '/tasks/:id', to: 'tasks#destroy'
  root 'pages#index'

end
