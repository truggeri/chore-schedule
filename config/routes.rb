Rails.application.routes.draw do
  root 'static_pages#index'

  resources :chores do
    get 'perform_now', on: :member
  end

  resources :category, only: %i[index show]
end
