Rails.application.routes.draw do
  match "*all", controller: "application", action: "cors_preflight_check", via: [:options]

  scope :api, defaults: { format: :json } do
    devise_for :users,
               controllers: { registrations: "api/registrations", sessions: "api/sessions" }
  end

  resources :todo_group, only: [:show, :create, :update, :destroy] do
    resources :todos
  end

  root "todos#index"
end
