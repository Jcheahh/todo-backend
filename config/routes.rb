Rails.application.routes.draw do
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]

  scope :api, defaults: { format: :json } do
    devise_for :users,
               controllers: { registrations: 'api/registrations', sessions: 'api/sessions' }
  end

  root 'todos#index'

  resources :todos
end
