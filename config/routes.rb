Rails.application.routes.draw do
  resources :bars
  scope :api, defaults: {format: :json} do
    resources :foos
  end

end
