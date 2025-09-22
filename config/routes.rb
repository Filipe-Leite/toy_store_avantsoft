Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get 'auth/validate', to: 'authentication#validate_token'

  resources :customers, only: [:index, :create, :update, :destroy, :show]
  resources :sales, only: [:create, :index, :show]
end
