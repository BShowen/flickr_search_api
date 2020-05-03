Rails.application.routes.draw do
  root "searches#new"
  post "/", to: "searches#create"
end
