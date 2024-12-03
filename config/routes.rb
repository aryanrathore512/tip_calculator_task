Rails.application.routes.draw do
  root 'calculations#index'
  resources :calculations, only: [:create]
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end
end
