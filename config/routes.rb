Maframe::Application.routes.draw do
  resources :nodes

  get "home/index"
  root to: "home#index"

  resources :projects

end
