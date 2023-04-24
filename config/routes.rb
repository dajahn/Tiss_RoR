Rails.application.routes.draw do
  
  root "main#index"

  get "registration", to: "registration#new"
  post "registration", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "person_search", to: "person#index"
  post "person_search", to: "person#search"

  get "course_search", to: "course#index"
  post "course_search", to: "course#search"

  get "project_search", to: "project#index"
  post "project_search", to: "project#search"

  get "thesis_search", to: "thesis#index"
  post "thesis_search", to: "thesis#search"

  get "person_details", to:"person#details"

  delete "logout", to: "sessions#destroy"
end
