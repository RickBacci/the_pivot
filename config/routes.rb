Rails.application.routes.draw do
  root to: "welcome#index"
  resources :jobs, only: [:index, :show]
  resources :categories, only: [:show, :index]
  resources :cart_jobs, only: [:index, :create, :destroy] do
    member do
      post :increment, :decrement
    end
  end
  resources :users, except: [:show] do
    resources :addresses, only: [:new, :create, :show]
  end
  namespace :admin do
    get "/dashboard", to: "admin#index"
    resources :jobs
    resources :orders, only: [:index, :show]
    resources :sales, only: [:index, :new, :create] do
      member do
        post :end_sale
      end
    end
  end
  resources :orders, only: [:index, :show, :create]
  get "/dashboard", to: "users#show"
  post "/dashboard", to: "addresses#create"
  get "/cart", to: "cart_jobs#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
