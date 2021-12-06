# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'statics#index'
  resources :statics
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
