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
    resource :cart, only: [:show] do
      post 'add_to_cart', to: 'carts#add_to_cart'
      post 'add_special_menu', to: 'carts#add_special_menu_to_cart', as: 'add_special_menu'
      delete 'remove_from_cart/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
      delete 'clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
      resources :cart_items, only: [:create, :destroy]
    end
    resources :orders do 
      post '/process_order', to: 'orders#create'
    end
  end
  resources :contacts, only: [:new, :create]
end
