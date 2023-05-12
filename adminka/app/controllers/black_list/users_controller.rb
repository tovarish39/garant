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
        status_by_moderator:nil,
        is_blocked_by_moderator:false
      )
    elsif  params[:newStatus] == 'Проверенный'
      user.update!(
        status_by_moderator:'Проверенный',
        is_blocked_by_moderator:false
      )

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
      black_list_user[:create_complaints_size] = create_complaints_by_user(user).size #
      black_list_user[:complaints_to_self_size]   = complaints_to_self(user).size
      black_list_user[:is_self_scamer]      = (user.is_self_scamer) ? 'Скамер' : 'Не скамер'
      black_list_user[:status_by_moderator] = user.status_by_moderator # 'Проверенный' | nil
      black_list_users << black_list_user
    end
    # puts black_list_users.inspect
    render json: black_list_users
  end

  private
  def create_complaints_by_user user
    user.complaints.where.not(status:'filling')
  end

  def complaints_to_self user
    complaints = Complaint.where(telegram_id:user.telegram_id)
    complaints.where.not(status:'filling') if complaints.any?
    complaints
  end
end
