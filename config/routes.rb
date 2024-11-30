Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post "/users" => "users#create"
  put "/users/:id" => "users#update"
  get "/users" => "users#index"
  get "/users/:id" => "users#show"

  post "/sessions" => "sessions#create"

  get "/exercises" => "exercises#index"
  get "/exercises/:id" => "exercises#show"

  get "/routines" => "routines#index"
  post "/routines" => "routines#create"

  post "/comments" => "comments#create"
  patch "/comments/:id" => "comments#update"
  delete "/comments/:id" => "comments#destroy"
end

# post - create
# put/patch - update
# delete - destroy
# get - show