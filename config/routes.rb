Rails.application.routes.draw do
  resources :rooms
  get 'tictactoe', to: "tictactoe#new", as: "tictactoe"
  get 'sessions/new', to: "sessions#new", as: "login_form"
  post 'sessions/create', to: "sessions#create", as: "login"
  delete 'sessions/destroy', to: "sessions#destroy", as: "logout"
  root 'welcome#index'
  resources :users
  get "/home", to: "users#home", as: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
