Rails.application.routes.draw do
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]
  
  scope :api, defaults: { format: :json } do
    # devise_for :users, only: :sessions
    devise_for :users
    as :user do
      post 'signin', to: 'devise/sessions#create', as: :user_session
      delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
    end
  end

  root "todos#index"

  resources :todos
end
