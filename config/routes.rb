Rails.application.routes.draw do
  root "todos#index"

  get "/todos", to: "todos#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
