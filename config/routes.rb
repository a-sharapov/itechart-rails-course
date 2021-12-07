# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'statics#index'
  devise_for :users
  resources :statics, path: '/info'
  get 'cabinet' => 'cabinet#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
