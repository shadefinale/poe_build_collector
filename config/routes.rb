Rails.application.routes.draw do
  root to: "builds#index"
  resources :authors, only: [:index, :show]
  resources :builds, only: [:index]
end