Rails.application.routes.draw do
  
  resources :contacts
  root 'welcome#index'
  devise_for :restaurants, controllers: { registrations: 'restaurants/registrations' }
  resources :restaurants do 
    resources :categories, only: [:new, :create]
    resources :food_items
    resources :special_menus do 
      resources :food_types do 
        resources :food_items
      end
    end 
    resources :tables, only: [:new, :create, :edit, :update, :index] do
      member do
        get 'download_qr_code'
      end
    end
    resources :carts, only: [:show, :create] do
      post 'add_to_cart', on: :member
      delete 'remove_from_cart/:id', to: 'carts#remove_from_cart', as: :remove_from_cart
    end
    resources :orders do 
      post '/process_order', to: 'orders#create'
    end
  end
  resources :contacts, only: [:new, :create]
end
