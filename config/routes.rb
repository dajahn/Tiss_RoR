Rails.application.routes.draw do
  
  root "main#index"

  get "registration", to: "registration#new"
  post "registration", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "person_search", to: "person#index"
  get "person_results", to: "person#search"
  get "person_details", to:"person#details"

  get "course_search", to: "course#index"
  get "course_results", to: "course#search"
  get "course_details", to:"course#details"

  get "project_search", to: "project#index"
  get "project_results", to: "project#search"
  get "project_details", to:"project#details"

  get "thesis_search", to: "thesis#index"
  get "thesis_results", to: "thesis#search"
  get "thesis_details", to:"thesis#details"


  delete "logout", to: "sessions#destroy"
end
