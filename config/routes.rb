Rails.application.routes.draw do
  root 'calculations#index'
  resources :calculations, only: [:create]
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/calculations_data', to: 'dashboard#calculations_data'
  end
end
