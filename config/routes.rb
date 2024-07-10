Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
    resources :categories
    resources :pages
    get 'dashboard', to: 'dashboard#index'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
