# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :products do
    member do
      post 'add_to_cart'
    end
  end

  resource :cart, only: [:show] do
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
    delete 'empty', to: 'carts#empty_cart', as: :empty
    resources :cart_items, only: [:update], module: 'carts'
  end

  root 'products#index'
end
