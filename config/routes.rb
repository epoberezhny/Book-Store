Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users,
             only: :omniauth_callbacks,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  scope '(:locale)' do
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
      post 'apply_coupon'
      resources :items, only: [:create, :destroy], controller: :order_items
    end

    resources :checkout, only: [:index, :show, :update]

    get 'omniauth/:provider', to: 'omniauth#localized', as: :localized_omniauth

    devise_for :users,
               skip: :omniauth_callbacks,
               controllers: {
                 registrations: 'users/registrations'
               },
               path_names: {
                 sign_in:  'log_in',
                 sign_out: 'log_out',
                 edit:     'settings'
               }

    root 'home#index'
  end
end
