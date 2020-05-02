Rails.application.routes.draw do
  root "static_pages#home"
  resources :searches, only: [:new, :create]
  resources :static_pages, only: [:home]
  get '/results', to: "searches#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
