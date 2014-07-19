Rails.application.routes.draw do
  resources :users, except: [:index]
  root 'home#index'
end
