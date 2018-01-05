Rails.application.routes.draw do
  root "static_pages#home"
  resources :courses do
    resources :subjects, only: %i(index)
  end
  resources :subjects
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  namespace :supervisor do
    resources :courses
  end
end
