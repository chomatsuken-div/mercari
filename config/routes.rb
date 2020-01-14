Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users,controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                   registrations: 'users/registrations' }
  
  devise_scope :user do
    get  'profile', to: 'users/registrations#profile'
    get  'phone', to: 'users/registrations#phone'
    post 'phone', to: 'users/registrations#phone'
    get  'address', to: 'users/registrations#address'
    post 'address', to: 'users/registrations#address'
    get  'card', to: 'users/registrations#card'
    post  'card', to: 'users/registrations#card'
  end

  resources :users, only: [:show, :new] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end

  get "products/search", to: "products#search"

  resources :products do
    member do
      post "purchase"
    end
    resources :payments, only: :create
  end

  namespace :api do
    resources :categories, only: :new, defaults: { format: 'json' }
  end

  resources :cards, only: [:new, :create]

end
