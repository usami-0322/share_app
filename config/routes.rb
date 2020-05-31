Rails.application.routes.draw do
  root 'home#top'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  get 'about', to: 'home#about'
  get 'policy', to: 'home#policy'

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes
    end
  end
  resources :posts, only: [:show, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
