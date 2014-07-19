Rails.application.routes.draw do
  resources :users, except: [:index] do
    collection do
      get '/sesame' => 'users#confirm'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'sign-up', to: 'users#new'
  get 'login', to: 'sessions#new'

  root 'home#index'
end
