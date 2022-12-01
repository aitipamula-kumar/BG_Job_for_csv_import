require 'resque/server'

Rails.application.routes.draw do
  resources :users do
    collection do
      post :import
    end
  end

  get 'home/index'
  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount Resque::Server, at: '/jobs'
end
