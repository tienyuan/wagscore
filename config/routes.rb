Rails.application.routes.draw do
  devise_for :users
  resources :locations
  resources :categories, except: [:show]

  get 'about' => 'static_pages#about'

  root 'locations#index'
end
