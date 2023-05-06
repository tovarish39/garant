# frozen_string_literal: true

class Garant::DealsController < ApplicationController
  def index; end

  def get_deals
    get_deals_json
  end

  def action_with_deal_from_administrator
    # debugger
    deal = Deal.find(params[:deal_id])
    deal.update(status: params[:administrator_action])
    comment_by_administrator = params[:comment] || ''
    deal.disputes.create(comment_by_moderator: comment_by_administrator) # и для модератора и для администратора

    get_deals_json
  end

  private

  def get_deal_with_users(deal)
    deal_json = deal.attributes
    deal_json[:seller]   = User.find(deal.seller_id)
                               .attributes.filter { |key| (key == 'telegram_id')  || (key == 'username') }
    deal_json[:custumer] = User.find(deal.custumer_id)
                               .attributes.filter { |key| (key == 'telegram_id')  || (key == 'username') }
    if deal.disputes.first
      deal_json[:dispute] = deal.disputes.first
                                .attributes.filter { |key| (key == 'dispute_lost') || (key == 'comment_by_moderator') }
    end
    deal_json
  end

  def get_deals_json
    deals = Deal.all
    # активные, которые оплаченные и без спора
    active  = deals.filter { |deal|  deal.status =~ /payed/ }
    # архивные, которые завершены или продавцом или покупателем или модератором при споре
    archive = deals.filter { |deal| (deal.status =~ /finished/) || (deal.status =~ /canceled/) }

    active_with_users_json  = active.map { |deal| get_deal_with_users(deal) }
    archive_with_users_json = archive.map { |deal| get_deal_with_users(deal) }

    render json: {
      active: active_with_users_json,
      archive: archive_with_users_json
    }
  end
end
