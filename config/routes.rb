Rails.application.routes.draw do
  root "courses#index"
  resources :courses do
    resources :subjects
  end
  resources :subjects
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  namespace :supervisor do
    resources :subjects
    resources :courses
    resources :course_subjects, only: %i(create update destroy)
    resources :user_courses, only: %i(create update destroy)
    resources :users
    resources :tasks
  end
  resources :user_courses, only: %i(update)
  resources :user_tasks, only: %i(new create update)
  resources :user_subjects, only: %i(update)
end
