# frozen_string_literal: true

Rails.application.routes.draw do
  root 'garant/homepage#index'
  namespace :garant do
    resources :moderators, only: %i[index]
    resources :deals,      only: %i[index]
    resources :finances,   only: %i[index]
  end

  get  '/getUsers',              to: 'garant/homepage#users'
  post '/send_message_to_users', to: 'garant/homepage#send_message_to_users'

  get  '/getModerators',    to: 'garant/moderators#getModerators'
  get  '/getDisputes',      to: 'garant/moderators#getDisputes'
  post '/create_moderator', to: 'garant/moderators#create'
  post '/update_comment',   to: 'garant/moderators#update_comment'
  post '/update_status',    to: 'garant/moderators#update_status'

  get '/getDeals', to: 'garant/deals#get_deals'
  post '/action_with_deal_from_administrator', to: 'garant/deals#action_with_deal_from_administrator'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
