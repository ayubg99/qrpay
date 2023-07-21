Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }, skip: :registrations
  resources :contacts
  root 'welcome#index'
  devise_for :restaurants, controllers: { 
    registrations: 'restaurants/registrations',
    sessions: 'restaurants/sessions' 
  }

  get '/admin_dashboard', to: 'admin_dashboard#index', as: 'admin_dashboard'
  resources :restaurants do 
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
      delete 'remove_from_cart/:food_item_id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
      delete 'remove_special_menu/:special_menu_id', to: 'carts#remove_special_menu', as: 'remove_special_menu'
      delete 'clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
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
