Rails.application.routes.draw do
  root 'static_pages#index'

  resources :chores do
    get 'perform_now', on: :member
  end
end
