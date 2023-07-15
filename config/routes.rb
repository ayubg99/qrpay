Rails.application.routes.draw do
  
  resources :contacts
  root 'welcome#index'
  devise_for :restaurants, controllers: { registrations: 'restaurants/registrations' }
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/dashboard/orders', to: 'dashboard#orders', as: 'dashboard_orders'
  get '/dashboard/history', to: 'dashboard#history', as: 'dashboard_history'
  get '/dashboard/tables', to: 'dashboard#tables', as: 'dashboard_tables'
  get '/dashboard/menu', to: 'dashboard#menu', as: 'dashboard_menu'
  get '/dashboard/special_menus', to: 'dashboard#special_menus', as: 'dashboard_special_menus'
  get '/dashboard/payment_information', to: 'dashboard#payment_information', as: 'dashboard_payment_information'
  patch '/dashboard/update_payment_information', to: 'dashboard#update_payment_information', as: 'update_payment_information'
  post '/dashboard/authenticate', to: 'dashboard#authenticate', as: 'authenticate_dashboard'
  post '/dashboard/unauthenticate', to: 'dashboard#unauthenticate', as: 'unauthenticate_dashboard'

  resources :restaurants do 
    resources :categories
    resources :food_items
    resources :special_menus do 
      resources :food_types do 
        resources :food_items
      end
    end 
    resources :tables do
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
      collection do
        get 'thank_you/:pdf_path', action: :thank_you, as: 'thank_you'
      end
    end
  end
  resources :contacts, only: [:new, :create]
  get '/receipts/:pdf_path/:restaurant_id', to: 'receipts#download', as: 'download_receipt'
end
