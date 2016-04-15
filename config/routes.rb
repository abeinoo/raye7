Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: "users/registrations"}
  resources :trips do
    collection do
      post 'join_trip', to: 'trips#join_trip'
    end
  end
end
