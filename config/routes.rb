Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post "/users" => "users#create"
  
  post "/sessions" => "sessions#create"

  get "/exercises" => "exercises#index"
  get "/exercises/:id" => "exercises#show"

  get "/routines" => "routines#index"
  post "/routines" => "routines#create"
end
