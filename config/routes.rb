Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  devise_for :users
  resources :users, only: [:index, :show]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
