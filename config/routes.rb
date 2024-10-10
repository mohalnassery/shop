Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :products do
    member do
      post 'add_to_cart'
    end
  end
  resource :cart, only: [:show] do
    post 'add_item'
    delete 'remove_item'
    delete 'empty_cart'
    patch 'update_quantity'
  end
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
