Rails.application.routes.draw do
  root 'homepage#index'
  
  resources :moderators, only: %i[index] 
  resources :deals,      only: %i[index] 

  get  '/getUsers',              to: 'homepage#users'
  post '/send_message_to_users', to: 'homepage#send_message_to_users'

  get  '/getModerators',    to: 'moderators#getModerators'
  get  '/getDisputes',      to: 'moderators#getDisputes'
  post '/create_moderator', to: 'moderators#create'
  post '/update_comment',   to: 'moderators#update_comment'
  post '/update_status',    to: 'moderators#update_status'
  
  get '/getDeals'                         , to: 'deals#get_deals'
  post '/finishing_deal_by_administrator', to:'deals#finishing'
  post '/canceling_deal_by_administrator', to:'deals#canceling' 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
