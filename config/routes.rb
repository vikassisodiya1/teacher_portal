# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'students#index'

  get 'teachers/:teacher_id/subjects/new', to: 'subjects#new', as: :new_teacher_subject
  post 'teachers/:teacher_id/subjects', to: 'subjects#create', as: :teacher_subjects

  resources :students, only: %i[index edit update destroy create]
  get 'add_student', to: 'students#new', as: 'add_student'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
