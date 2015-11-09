Rails.application.routes.draw do
  devise_for :users

  root 'players#index'
  resources :players

  resources :games

  resources :studies


end
