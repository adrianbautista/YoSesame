Rails.application.routes.draw do
  resources :users, except: [:index] do
    collection do
      get '/sesame' => 'users#confirm'
    end
  end
  root 'home#index'
end
