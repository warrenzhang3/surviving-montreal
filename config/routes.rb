# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :articles, only: [:index, :show, :new, :create] do
    post 'bookmark', on: :member
    get 'image', on: :member, to: 'articles#image' # Custom route for image requests
    resources :comments, only: :create
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

  resources :badges, only: [:show]
  get 'my_badges', to: 'users#my_badges', as: 'my_badges'
  resources :users, only: [:show]
end
