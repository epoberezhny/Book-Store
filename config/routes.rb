Rails.application.routes.draw do
  devise_for :admins
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: [:show] do
    get '(category-:category)', action: :index, on: :collection, as: ''
    resources :reviews, only: [:create]
  end

  resource :cart, only: [:show]

  namespace :users do
    resources :orders, only: [:show] do
      get '(status/:status)', action: :index, on: :collection, as: ''
    end
  end

  resource :order, only: [:update] do
    post      :apply_coupon
    resources :items, only: [:create, :destroy], controller: :order_items
  end

  resources :checkout, only: [:index, :show, :update]

  devise_for :users,
              controllers: {
                registrations: 'users/registrations',
                omniauth_callbacks: 'users/omniauth_callbacks'
              },
              path_names: {
                sign_in:  'log_in',
                sign_out: 'log_out',
                edit:     'settings'
              }

  root 'home#index'
end
