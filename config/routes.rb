Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users,controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                   registrations: 'users/registrations' }

  resources :users, only: [:show, :new] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end

  resources :products, only: [:index, :new, :create, :show] do
    member do
      post "purchase"
    end
  end

  namespace :api do
    resources :categories, only: :new, defaults: { format: 'json' }
  end

end
