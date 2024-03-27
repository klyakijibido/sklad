Rails.application.routes.draw do
  root 'products#index'

  resources :products

  scope :callbacks, controller: :callbacks, format: false do
    post :telegram
  end
end
