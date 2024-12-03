Rails.application.routes.draw do
  root 'calculations#create'
  resources :calculations, only: [:create]
end
