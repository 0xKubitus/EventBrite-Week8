Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:'events#index'

  devise_for :users
  
  resources :events, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :checkouts, only: [:new, :create]
    resources :attendances, only: [:index]
    resources :event_images, only: [:create]
  end

  resources :users, only: [:show, :edit, :update] do
    resources :profile_images, only: [:create]
  end
  
  namespace :admin do
    root to:"admin#index"
    resources :users, :events
    resources :event_submissions, only: [:index, :show, :update]
  end
  
end
