Rails.application.routes.draw do
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]

  root "todos#index"

  resources :todos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
