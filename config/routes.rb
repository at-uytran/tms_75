Rails.application.routes.draw do
  root "static_pages#home"
  resources :courses do
    resources :subjects do
      resources :tasks
    end
  end
  resources :subjects
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :tasks
  namespace :supervisor do
    resources :courses
    resources :course_subjects, only: %i(create update destroy)
    resources :user_courses, only: %i(create update destroy)
  end
  resources :tasks
  resources :subjects do
    resources :user_tasks
  end
  resources :user_tasks
end
