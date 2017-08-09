Rails.application.routes.draw do
  resources :images
  get 'authn/whoami'

  get 'authn/checkme'

  mount_devise_token_auth_for 'User', at: 'auth'

  scope :api, defaults: { format: :json } do
    resources :foos
    resources :bars
    resources :cities
    resources :states
    resources :images, except: [:new, :edit]
  end

  get '/ui', to: 'ui#index'
  get '/ui#', to: 'ui#index'

  root 'ui#index'

end
