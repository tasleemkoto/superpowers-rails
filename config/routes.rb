Rails.application.routes.draw do
  devise_for :users
  get "user", to: "users#show", as: :user_profile
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :superpowers do
    resources :bookings, only: [:new, :create, :show]
  end
  resources :bookings, only: [:edit, :index, :update, :destroy]
  post 'buy_superpower/:superpower_id', to: "bookings#buy", as: :buy_superpower
end
