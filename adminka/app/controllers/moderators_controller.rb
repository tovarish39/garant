# frozen_string_literal: true

class ModeratorsController < ApplicationController
  def getModerators
    render_moderators
  end

  def update_comment
    Moderator.find(params[:moderator_id]).update(comment: params[:comment])
    render_moderators
  end

  def update_status
    new_status = (params[:newStatus] == 'активный' ? 'active' : 'inactive')
    Moderator.find(params[:moderator_id]).update(rights_status: new_status)
    render_moderators
  end

  def create
    moderator = Moderator.find_by(telegram_id: params[:telegram_id])
    if moderator
      moderator.update(rights_status: 'active')
    else
      Moderator.create(
        telegram_id: params[:telegram_id],
        rights_status: 'active'
      )
    end
    render_moderators
  end

  def getDisputes
    # // finished_by_day, finished_by_week, finished_by_month, pending_disputes
    pending_disputes = Dispute.where(status: 'pending_moderator')
    finished_disputes = Dispute.where(status: 'finished')
    time_now = Time.now

    f_by_day   = []
    f_by_week  = []
    f_by_month = []

    finished_disputes.each do |dispute|
      f_by_day << dispute if (Time.now - 1.day) < dispute.updated_at
      f_by_week  << dispute if (Time.now - 1.week)  < dispute.updated_at
      f_by_month << dispute if (Time.now - 1.month) < dispute.updated_at
    end

    render json: {
      finished_by_day: f_by_day.size,
      finished_by_week: f_by_week.size,
      finished_by_month: f_by_month.size,
      pending_disputes: pending_disputes.size
    }
  end

  private

  def render_moderators
    # get 'active' & 'inactive' moderators, not nil
    # render :json => @notes.to_json(:include => { :user => { :only => :username } })

    moderators = Moderator.where("rights_status = 'active' or rights_status = 'inactive'").order(:created_at)
    render json: moderators, include: :disputes
  end
end
