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

  resources :carts do
    member do
      delete :empty
      post :checkout
      get :success
    end
  end

  resource :cart, only: [:show] do
    delete :empty, to: 'carts#empty_cart'
    post :checkout, to: 'carts#checkout'
    get :success, to: 'carts#success'
    resources :cart_items, only: [:update, :destroy], controller: 'carts/cart_items'
  end

  root 'products#index'
end
