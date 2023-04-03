Rails.application.routes.draw do
  
  root "main#index"

  get "registration", to: "registration#new"
  post "registration", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"
end
