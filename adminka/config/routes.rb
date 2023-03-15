Rails.application.routes.draw do
  root 'homepage#index'
  
  resources :moderators, only: %i[index] 
  resources :deals,      only: %i[index] 

  get  '/getUsers',      to: 'homepage#users'
  get  '/getModerators', to: 'moderators#getModerators'
  post '/send_message_to_users', to: 'homepage#send_message_to_users'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
