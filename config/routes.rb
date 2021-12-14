Rails.application.routes.draw do
  root to: 'statics#index'
  devise_for :users
  get 'cabinet' => 'cabinet#index', :as => :user_root
  get 'users' => redirect('cabinet')
  patch 'cabinet' => 'cabinet#change_person'

  resources :people, path: '/cabinet/persons' do
    with_options(except: [:index]) do |o| 
      o.resource :categories
    end
  end

  with_options(except: [:index, :show]) do |o| 
    o.resource :transactions, path: '/cabinet/transactions'
  end

  resources :statics, path: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
