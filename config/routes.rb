Rails.application.routes.draw do
  get 'products/show'
  root 'home#index'
  get 'static_pages/contact'
  get 'static_pages/about'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :cart_items, only: [:update, :destroy]
  resources :orders, only: [:index, :new, :create, :show]

  namespace :admin do
    resources :orders do
      member do
        patch :update_status
      end
    end
    resources :products
    resources :categories
    resources :pages
    get 'dashboard', to: 'dashboard#index'
  end

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :custom_destroy_user_session
  end

  resources :carts, only: [:show] do
    post 'add_product', on: :member
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
