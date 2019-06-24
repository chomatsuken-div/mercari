Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users,controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                   registrations: 'users/registrations' }

  resources :users, only: [:show, :new] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end

  get "products/search", to: "products#search"

  resources :products, only: [:index, :new, :create, :show, :destroy] do
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
