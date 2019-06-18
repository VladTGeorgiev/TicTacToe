Rails.application.routes.draw do
  resources :leaderboards, only: [:index]
  resources :rooms
  post "rooms/new", to: "rooms#create", as: "start_room"
  post "rooms/:id/concede", to: "rooms#concede", as: "concede"
  get 'tictactoe', to: "tictactoe#new", as: "tictactoe"
  get 'login', to: "sessions#new", as: "login_form"
  post 'login', to: "sessions#create", as: "login"
  delete 'logout', to: "sessions#destroy", as: "logout"
  root 'welcome#index'
  get "rooms/:id/history/:turn", to: "rooms#history", as: "history"
  resources :users
  get "/home", to: "users#home", as: "home"
  get "tictactoe/info", to: "tictactoe#info", as: "tictactoe_info"
  get "/about", to: "welcome#about", as: "about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
