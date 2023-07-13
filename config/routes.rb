Rails.application.routes.draw do
  
  resources :contacts
  root 'welcome#index'
  devise_for :restaurants, controllers: { registrations: 'restaurants/registrations' }
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/dashboard/orders', to: 'dashboard#orders', as: 'dashboard_orders'
  get '/dashboard/tables', to: 'dashboard#tables', as: 'dashboard_tables'
  get '/dashboard/menu', to: 'dashboard#menu', as: 'dashboard_menu'
  get '/dashboard/special_menus', to: 'dashboard#special_menus', as: 'dashboard_special_menus'
  resources :restaurants do 
    resources :categories
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
      delete 'cart_items/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
      delete 'clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
      resources :cart_items, only: [:create] do 
        patch :increase_quantity, on: :member
        patch :decrease_quantity, on: :member
      end
    end
    resources :orders, only: [:new, :create, :destroy] do 
      member do
        get 'success', to: 'orders#success', as: 'success'
        get 'cancel', to: 'orders#cancel', as: 'cancel'
      end
    end
  end
  resources :contacts, only: [:new, :create]
end
