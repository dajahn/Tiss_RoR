Rails.application.routes.draw do
  
  root "main#index"

  get "registration", to: "registration#new"
  post "registration", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "person_search", to: "person#index"
  get "person_results", to: "person#search"

  get "course_search", to: "course#index"
  get "course_results", to: "course#search"

  get "project_search", to: "project#index"
  get "project_results", to: "project#search"

  get "thesis_search", to: "thesis#index"
  get "thesis_results", to: "thesis#search"

  get "person_details", to:"person#details"

  delete "logout", to: "sessions#destroy"
end
