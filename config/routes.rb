require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root 'users#index'
      resources :users
      resources :sessions, only: [:create, :destroy]
      resources :confirmations, only: [:create]
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
      resources :story_downloads, only: [:index, :create]
      resources :story_reads, only: [:create]
      resources :tags, only: [:index]
      resources :notifications, only: [:index, :create]
      resource :registered_tokens, only: [:update]
      resource :settings

      scope '/tags/:tag_id', as: :tags, module: 'tags' do
        resources :stories, only: [:index]
      end
    end
  end

  post 'create_user' => 'users#create', as: :create_user

  match 'download_web_guide', to: 'home#download_web_guide', via: :get
  match 'download_mobile_guide', to: 'home#download_mobile_guide', via: :get


  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/api/v1/sidekiq"
end
