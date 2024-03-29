class StateMachine
    class_eval do
      include AASM
      aasm do
        state :await_userTo_data
  
        event :await_userTo_data_action, from: :await_userTo_data do
          transitions if: -> { text_mes?(T_cancel[$lg]) }      , after: :cancel          , to: :start # "Отмена"
          transitions if: -> {user_shared? &&  bot_has_userTo?}, after: :run_to_userTo   , to: :userTo            # userTo    найден из своего списка пользователей
          transitions if: -> {user_shared? && !bot_has_userTo?}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден из своего списка пользователей
          transitions if: -> {text_mes? && !bot_has_userTo?}   , after: :userTo_not_found, to: :await_userTo_data # userTo не найден из id || username
          transitions if: -> {text_mes? && bot_has_userTo?}    , after: :run_to_userTo   , to: :userTo # userTo    найден из id || username
        end
      end
    end
end
  
def user_shared?
  ($mes.respond_to?('user_shared') ? true : false)
end

def bot_has_userTo?
  if user_shared?() # при поиске из контактов
    telegram_id = $mes.user_shared.user_id
    user_by_telegram_id = try_by_telegram_id(telegram_id)
    $userTo = user_by_telegram_id

  elsif   text_mes?()  # при вводе telegram_id или username
    telegram_id = $mes.text.gsub(/\D/, '')
    user_by_telegram_id = try_by_telegram_id(telegram_id) 
    user_by_username    = try_by_username()
    $userTo = user_by_telegram_id || user_by_username
  end
  $user.update(userTo_id:$userTo.id) if $userTo
  $userTo # User || nil
end

  def try_by_telegram_id telegram_id 
    found_user = User.find_by(telegram_id:telegram_id)
    if found_user
      return found_user if $user.telegram_id != found_user.telegram_id
    end
    nil
  end
  
  def try_by_username
    id = $mes.text =~ /^id/i
    unless id
      username = $mes.text.gsub(/[@, \s]/, '')
      found_user = User.find_by(username:username)
      if found_user 
        return found_user if $user.username != found_user.username  
      end
    end
    nil
  end

  def userTo_not_found
    puts 'here'
    Send.mes(B_userTo_not_found[$lg])  if text_mes? # при вводе telegram_id || username
    Send.mes(B_userTo_not_subscr[$lg]) if user_shared? # при выборе из списка контактов
  end
  


def formatted_avarage_num numbers
  avarage = (numbers.sum.to_f /  numbers.size).round(1)
  "#{avarage}/5"
end

def get_reiting_userTo
  whith_reiting = Deal.with_reiting($userTo)
  if whith_reiting.any?
    marks = whith_reiting.map(&:grade).map(&:to_i)
    formatted_avarage_num(marks)
  else 
    nil 
  end
end

def run_to_userTo
  userTo = User.find($user.userTo_id)
  $user.update(
    userTo_id: userTo.id,
    role: nil,
    currency: nil,
    amount: nil,
    conditions: nil
  )

  closed_deals = Deal.closed_statuses(DEAL_Closed_Statuses)

  userTo_as_seller_of_closed_deals   = closed_deals.as_seller($userTo)
  userTo_as_customer_of_closed_deals = closed_deals.as_customer($userTo) 

  userTo_comments = userTo_as_seller_of_closed_deals.with_comment
  # userTo_disputes = closed_deals.as_seller_OR_as_customer($userTo).filter {|deal| deal.disputes.any? } 
  userTo_deals_raw = closed_deals.as_seller_OR_as_customer($userTo)
  
  userTo_disputes = [] 
  
  userTo_deals_raw.each do |deal| 
    if deal.disputes.any? 
      dispute = deal.disputes[0]
      userTo_disputes  << dispute if (dispute.dispute_lost == 'seller_lost') || (dispute.dispute_lost == 'custumer_lost')
    end
  end

  



  userTo_reiting  = get_reiting_userTo()

  Send.mes(B_info[$lg], M::Reply.start)
  Send.mes(
    B_userTo_info.call(
      userTo_as_seller_of_closed_deals.size, 
      userTo_as_customer_of_closed_deals.size, 
      userTo_reiting
      ), 
    M::Inline.offer_deal(
      userTo_comments.size,
      userTo_disputes.size
    )
  )
end

def cancel
  to_start
end