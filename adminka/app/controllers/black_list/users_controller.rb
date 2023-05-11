class BlackList::UsersController < ApplicationController
  def index
  end

  def update
    user = BlackListUser.find(params[:id])
    if params[:newStatus] == 'Не скамер'
      user.update!(
        is_self_scamer:false,
        status_by_moderator:nil
      ) 
    elsif  params[:newStatus] == 'Скамер'
      user.update!(
        is_self_scamer:true,
        status_by_moderator:nil
      )
    elsif  params[:newStatus] == 'Проверенный'
      user.update!(status_by_moderator:'Проверенный')
    end                    
    self.users
  end

  def users
    black_list_users = []
    BlackListUser.all.order(:created_at).each do |user|
      black_list_user = {}
      black_list_user[:id]                  = user.id
      black_list_user[:telegram_id]         = user.telegram_id
      black_list_user[:username]            = user.username
      black_list_user[:created_at]          = user.created_at.strftime('(%H:%M) %d-%m-%y')
      black_list_user[:create_scamers_size] = create_scamers_by_user(user).size
      black_list_user[:self_scamers_size]   = self_scamers(user).size
      black_list_user[:is_self_scamer]      = (user.is_self_scamer) ? 'Скамер' : 'Не скамер'
      black_list_user[:status_by_moderator] = user.status_by_moderator # 'Проверенный' | nil
      black_list_users << black_list_user
    end
    # puts black_list_users.inspect
    render json: black_list_users
  end

  private
  def create_scamers_by_user user
    user.scamers.where.not(status:'filling')
  end

  def self_scamers user
    scamers = Complaint.where(telegram_id:user.telegram_id)
    scamers.where.not(status:'filling') if scamers.any?
    scamers
  end
end
