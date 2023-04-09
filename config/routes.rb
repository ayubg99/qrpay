Rails.application.routes.draw do
  resources :restaurants do 
    resources :food_items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
