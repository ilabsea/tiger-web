Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions, :only => [:create, :destroy]
      resources :stories do
        resources :scenes
        resources :scene_actions do
          put :update_order, on: :collection
        end
      end

      resources :scene_actions
    end
  end

  post 'create_user' => 'users#create', as: :create_user

end
