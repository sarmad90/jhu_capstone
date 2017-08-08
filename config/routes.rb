Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  scope :api, defaults: {format: :json} do
    resources :foos
    resources :bars
    resources :cities
    resources :states
  end

  get '/ui', to: 'ui#index'
  get '/ui#', to: 'ui#index'

  root 'ui#index'

end
