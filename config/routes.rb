Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions, only: [:create, :destroy]
      resources :stories, only: [:index, :create, :update, :destroy] do
        resources :scenes, only: [:index, :create, :update, :destroy] do
          put :update_order, on: :collection
        end

        resources :questions, only: [:index, :create, :update, :destroy] do
          put :update_order, on: :collection
        end

        post :clone, on: :member
      end

      resources :story_downloads, only: [:index, :create]
    end
  end

  post 'create_user' => 'users#create', as: :create_user
end
