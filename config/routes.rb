Rails.application.routes.draw do
  get 'products/show'
  root 'home#index'
  get 'static_pages/contact'
  get 'static_pages/about'

  devise_for :users

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  namespace :admin do
    resources :products
    resources :categories
    resources :pages
    get 'dashboard', to: 'dashboard#index'
  end
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :custom_destroy_user_session
  end


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
