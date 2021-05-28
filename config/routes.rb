Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :photos do
    resources :answers, only: [:create, :new, :destroy]
  end
  
  resources :users, only: [:show, :create] do
    get :search, on: :collection
  end
  resources :likes, only: [:create, :destroy]
  
end
