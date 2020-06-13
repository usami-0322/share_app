Rails.application.routes.draw do
  root 'home#top'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  get 'about', to: 'home#about'
  get 'policy', to: 'home#policy'
  post 'guest_sign_in', to: 'homes#new_guest'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes
    end
  end
  resources :posts, only: [:show, :create, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :favorites, only: [:create, :destroy]
  resources :managemants, only: [:index, :new, :create, :destroy]
end
