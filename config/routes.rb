Rails.application.routes.draw do
  root to: 'statics#index'
  devise_for :users
  get 'cabinet' => 'cabinet#index', :as => :user_root
  get 'users' => redirect('cabinet')

  resources :statics, path: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
