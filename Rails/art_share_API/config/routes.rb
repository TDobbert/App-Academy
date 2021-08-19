Rails.application.routes.draw do
  resources :users, only: [:index, :show, :update, :create, :destroy]
  resources :artworks, only: [:show, :update, :create, :destroy]

  resources :users do
    resources :artworks
  end
end
