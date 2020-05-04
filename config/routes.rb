Rails.application.routes.draw do
  root "searches#new"
  post "/", to: "searches#create"
  get '/show', to: "searches#show"
end
