Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    resources :rentings, only: [ :create, :destroy, :edit, :update]
    get 'opensea/retrieve_assets'
    post 'opensea/create_listing'
    post 'opensea/place_bid'
  end
  resources :rentings, only: [:index]
end
