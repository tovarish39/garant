# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('garant/users') #   'garant/homepage#index'
  
  namespace :black_list do
    resources :users,      only: %i[index update]    
  end
  get '/getBlackListUsers', to: 'black_list/users#users'



  namespace :garant do
    resources :users,      only: %i[index]
    resources :moderators, only: %i[index create update]
    resources :deals,      only: %i[index]
    resources :finances,   only: %i[index]
  end


  get  '/getUsers',              to: 'garant/users#users'
  get  '/getGarantUserStatistic',to: 'garant/users#statistic'
  post '/send_message_to_users', to: 'garant/users#send_message_to_users'

  get  '/getModerators',    to: 'garant/moderators#getModerators'


  get '/getDeals', to: 'garant/deals#get_deals'
  post '/action_with_deal_from_administrator', to: 'garant/deals#action_with_deal_from_administrator'
end
