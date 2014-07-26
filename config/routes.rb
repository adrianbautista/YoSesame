Rails.application.routes.draw do
  resources :users, except: [:index] do
    collection do
      get "/sesame/:token" => 'users#confirm'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'sign-up', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'holding', to: 'sessions#holding'

  get 'dashboard', to: 'dashboard#index'

  root 'home#index'
end
