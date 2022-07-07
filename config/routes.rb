Rails.application.routes.draw do
  resources :books
  get 'users', to: "users#index"
  post 'users', to: "users#create"
  get 'users/:id', to: "users#show"
  put 'users/:id', to: "users#update"
  patch 'users/:id', to: "users#update"
  delete 'users/:id', to: "users#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
