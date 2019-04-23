Rails.application.routes.draw do
  devise_for :accounts
  root 'static_pages#index'

  resources :chores, only: %i[index show create destroy] do
    get 'perform_now', on: :member
  end
  get 'dashboard', to: 'static_pages#dashboard'

  resources :category, only: %i[index show create destroy]
end
