Rails.application.routes.draw do
  resources :contacts
  resources :tables
  root 'welcome#index'
  devise_for :restaurants, controllers: { registrations: 'restaurants/registrations' }
  resources :restaurants do 
    resources :food_items
    resources :tables do
      member do
        get 'download_qr_code'
      end
    end
  end
  resources :contacts, only: [:new, :create]
end
