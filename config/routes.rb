require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root 'players#index'
  resources :players

  resources :games

  resources :studies

  resources :pgns

  mount Sidekiq::Web, at: '/sidekiq'
end
