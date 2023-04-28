# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homepage#index'

  resources :finances,   only: %i[index]
  resources :moderators, only: %i[index]
  resources :deals,      only: %i[index]

  get  '/getUsers',              to: 'homepage#users'
  post '/send_message_to_users', to: 'homepage#send_message_to_users'

  get  '/getModerators',    to: 'moderators#getModerators'
  get  '/getDisputes',      to: 'moderators#getDisputes'
  post '/create_moderator', to: 'moderators#create'
  post '/update_comment',   to: 'moderators#update_comment'
  post '/update_status',    to: 'moderators#update_status'

  get '/getDeals', to: 'deals#get_deals'
  post '/action_with_deal_from_administrator', to: 'deals#action_with_deal_from_administrator'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
