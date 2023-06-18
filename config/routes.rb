Rails.application.routes.draw do
  
  root "main#index"

  get "registration", to: "registration#new"
  post "registration", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "person_search", to: "person#index"
  get "person_results", to: "person#search"
  get "person_details", to:"person#details"
  post "person_favorite", to:"person#addFavorite"
  delete "person_favorite", to:"person#removeFavorite"
  put "person_favorite", to: "person#update"
  get "person_report", to: "person#report"
  get "person_full_report", to: "person#fullReport"

  get "course_search", to: "course#index"
  get "course_results", to: "course#search"
  get "course_details", to:"course#details"
  post "course_favorite", to:"course#addFavorite"
  delete "course_favorite", to:"course#removeFavorite"
  put "course_favorite", to: "course#update"
  get "course_report", to: "course#report"

  get "project_search", to: "project#index"
  get "project_results", to: "project#search"
  get "project_details", to:"project#details"
  post "project_favorite", to:"project#addFavorite"
  delete "project_favorite", to:"project#removeFavorite"
  put "project_favorite", to: "project#update"
  get "project_report", to: "project#report"

  get "thesis_search", to: "thesis#index"
  get "thesis_results", to: "thesis#search"
  get "thesis_details", to:"thesis#details"
  post "thesis_favorite", to:"thesis#addFavorite"
  delete "thesis_favorite", to:"thesis#removeFavorite"
  put "thesis_favorite", to: "thesis#update"
  get "thesis_report", to: "thesis#report"

  get "favorites", to: "favorites#list"

  get "reports", to: "search#menu"

  delete "logout", to: "sessions#destroy"
end
