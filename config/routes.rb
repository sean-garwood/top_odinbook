Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :likes, :comments, only: [ :create, :destroy ]
  end

  devise_for :users

  resources :follow_requests,
    only: %i[index new create destroy],
    controller: :follow_requests do
    member do
      patch :accept
    end
  end

  resource :profile, only: %i[show edit update], controller: :profile, as: :profile
  resolve ("Profile") { [ :profile ] }

  get "discover" => "users#index", as: :discover

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  get "feed" => "posts#index", as: "feed"
end
