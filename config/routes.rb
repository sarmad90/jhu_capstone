Rails.application.routes.draw do
  get 'authn/whoami'

  get 'authn/checkme'

  mount_devise_token_auth_for 'User', at: 'auth'

  scope :api, defaults: { format: :json } do
    resources :foos
    resources :bars
    resources :cities
    resources :states
    resources :images, except: [:new, :edit] do
      post 'thing_images', controller: :thing_images, action: :create
      get 'thing_images', controller: :thing_images, action: :image_things
      get 'linkable_things', controller: :thing_images, action: :linkable_things
    end
    resources :things, except: [:new, :edit] do
      resources :thing_images, except: [:new, :edit]
    end
  end

  get '/ui', to: 'ui#index'
  get '/ui#', to: 'ui#index'

  root 'ui#index'

end
