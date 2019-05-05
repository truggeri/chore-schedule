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
end
