Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root 'users#index'
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

      resource :chart, only: [:show]
      resources :story_downloads, only: [:create]
      resources :story_reads, only: [:create]
      resources :tags, only: [:index]

      scope '/tags/:tag_id', as: :tags, module: 'tags' do
        resources :stories, only: [:index]
      end
    end
  end

  post 'create_user' => 'users#create', as: :create_user
end
