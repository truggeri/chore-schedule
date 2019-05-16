Rails.application.routes.draw do
  devise_for :accounts

  authenticated :account do
    root 'static_pages#dashboard'
  end

  unauthenticated :account do
    root 'static_pages#index'
  end

  get 'dashboard', to: 'static_pages#dashboard'
  resources :chores, only: %i[index show create destroy] do
    get 'perform_now', on: :member
  end
  resources :category, only: %i[index show create destroy]

  get '/service-worker.js', to: "service_worker#service_worker"
  get '/manifest.json',     to: "service_worker#manifest"
  get '/offline.html',      to: "service_worker#offline"
end
