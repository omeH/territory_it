Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
      resources :ratings, only: :update
      resources :top_ratings, only: :index
      resources :authors, only: :index
    end
  end
end
