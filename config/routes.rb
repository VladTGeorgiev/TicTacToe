Rails.application.routes.draw do
  resources :rooms
  post "rooms/new", to: "rooms#create", as: "start_room"
  post "rooms/:id/concede", to: "rooms#concede", as: "concede"
  get 'tictactoe', to: "tictactoe#new", as: "tictactoe"
  get 'sessions/new', to: "sessions#new", as: "login_form"
  post 'sessions/create', to: "sessions#create", as: "login"
  delete 'sessions/destroy', to: "sessions#destroy", as: "logout"
  root 'welcome#index'
  resources :users
  get "/home", to: "users#home", as: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
