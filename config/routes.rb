Rails.application.routes.draw do

  scope :api, defaults: {format: :json} do
    resources :foos
    resources :bars
  end

  get :ui, to: 'ui#index'
  root 'ui#index'

end
