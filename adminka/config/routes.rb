# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('garant/users') #   'garant/homepage#index'
  
  namespace :black_list do
    resources :users,      only: %i[index]    
  end


  namespace :garant do
    resources :users,      only: %i[index]
    resources :moderators, only: %i[index]
    resources :deals,      only: %i[index]
    resources :finances,   only: %i[index]
  end

  get  '/getUsers',              to: 'garant/users#users'
  get  '/getGarantUserStatistic',to: 'garant/users#statistic'
  post '/send_message_to_users', to: 'garant/users#send_message_to_users'

  get  '/getModerators',    to: 'garant/users#getModerators'
  get  '/getDisputes',      to: 'garant/users#getDisputes'
  post '/create_moderator', to: 'garant/users#create'
  post '/update_comment',   to: 'garant/users#update_comment'
  post '/update_status',    to: 'garant/users#update_status'

  get '/getDeals', to: 'garant/deals#get_deals'
  post '/action_with_deal_from_administrator', to: 'garant/deals#action_with_deal_from_administrator'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
