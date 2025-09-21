Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

  resources :customers, only: [:index, :create, :update, :destroy, :show]
  resources :sales, only: [:create, :index, :show]
end
