Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#index"

  resources :users, controller: "users", only: [:show, :edit, :update, :destroy]

  get "/sign_in" => "users#new", as: "sign_in"
  post "/log_in" => "users#create"
  post "/sign_up" => "static#create", as: "users"
  delete "/sign_out" => "static#destroy", as: "sign_out"

  resources :books
end
