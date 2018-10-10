Rails.application.routes.draw do
  root to: 'finder#index'
  post '/', to: 'finder#index'
  get "outlets", to: "outlets#index"
end
