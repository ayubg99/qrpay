Rails.application.routes.draw do
  resources :contacts
  resources :tables
  root 'welcome#index'
  devise_for :restaurants, controllers: { registrations: 'restaurants/registrations' }
  resources :restaurants do 
    resources :categories, only: [:new, :create]
    resources :food_items
    resources :tables, only: [:new, :create, :edit, :update, :index] do
      member do
        get 'download_qr_code'
      end
    end
  end
  resources :contacts, only: [:new, :create]
end
