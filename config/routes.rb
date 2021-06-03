Rails.application.routes.draw do
  get 'search/search'
  get 'users/show'
  devise_for :users
  root to: "homes#top"
  get "home/about", to: "homes#about"
  get "search" => "search#search"
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
