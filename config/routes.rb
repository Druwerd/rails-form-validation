Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'pages#index'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  namespace :form_validations do
    resources :users, only: %i[create update]
  end
end
