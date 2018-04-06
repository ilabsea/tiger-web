Rails.application.routes.draw do
  devise_for :users
  root :to => "layouts#index"

  resources :users, except: :create

  scope "api" do
    resources :stories
  end

  get '*path', to: 'layouts#index'

  post 'create_user' => 'users#create', as: :create_user

end
