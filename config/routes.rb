Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :categories
    resources :pages
    get 'dashboard', to: 'dashboard#index'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
