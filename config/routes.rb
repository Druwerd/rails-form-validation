Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'pages#index'
  get 'pages/secret'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create]
  namespace :form_validations do
    resources :users, only: %i[create update]
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
