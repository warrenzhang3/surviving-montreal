# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :articles, only: [:index, :show, :new, :create] do
    post 'bookmark', on: :member
    collection do
      get 'bookmarked'
    end
  end

  resources :events, only: [:index, :show, :new, :create] do
    member do
      post 'going'
    end
  end

  get 'my_events' => 'events#my_events', as: :my_events
end
