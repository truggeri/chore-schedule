Rails.application.routes.draw do
  devise_for :accounts

  authenticated :account do
    root 'static_pages#dashboard'
  end

  unauthenticated :account do
    root 'static_pages#index'
  end

  get 'dashboard', to: 'static_pages#dashboard'
  resources :category, only: %i[index show create destroy]
  resources :chores,   only: %i[index show create update destroy] do
    get 'assign',      on: :member
    get 'perform_now', on: :member
  end

  get '/service-worker', to: "service_worker#service_worker"
  get '/manifest',       to: "service_worker#manifest"
  get '/offline',        to: "service_worker#offline"
end
