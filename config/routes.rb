Rails.application.routes.draw do
  devise_for :users
  resources :locations do
    post 'location_flagged', :action => :flag_location
  end
  resources :categories, except: [:show]

  get 'about' => 'static_pages#about'

  root 'locations#index'
end
