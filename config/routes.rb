Rails.application.routes.draw do
  get 'sessions/new', to: "sessions#new", as: "login_form"
  post 'sessions/create', to: "sessions#create", as: "login"
  post 'sessions/destroy', to: "sessions#destroy", as: "logout"
  root 'welcome#index'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
