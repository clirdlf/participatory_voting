# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :proposals do
    member do
      put 'like'
      put 'unlike'
    end
  end

  get 'stats', to: 'proposals#stats'
  get 'home', to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'proposals#index'
  # root 'pages#home'

end
