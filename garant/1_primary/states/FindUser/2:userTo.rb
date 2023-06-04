class StateMachine
    class_eval do
      include AASM
      aasm do
        state :userTo
  
        event :userTo_action, from: :userTo do
          ## UserToActions
          transitions if: -> {data?(/Comments/) &&  has_comments?}, after: :view_comments            , to: :userTo # "Отзывы"
          transitions if: -> {data?(/Comments/) && !has_comments?}, after: :no_comments              , to: :userTo # "Отзывы"
          transitions if: -> {data?(/Disputes/)                  }, after: :view_type_of_disputes    , to: :userTo # "Комментарии"
          transitions if: -> {data?(/Offer_deal/)                }, after: :choose_role              , to: :userTo # "Предложить сделку"
          ## Comments TypeOfDisputes Role CurrencyTypes
          transitions if: -> { data?(/Back_to userTo_actions/)   }, after: :to_userTo_from_back      , to: :userTo # "Назад"
          ## TypeOfDisputes
          transitions if: -> {data?(/Won_disputes/)              }, after: :disputes_won             , to: :userTo # "Выйграл споров"
          transitions if: -> {data?(/Lost_disputes/)             }, after: :disputes_lost            , to: :userTo # "Проиграл споров"
          ## WonDisputes LostDisputes
          transitions if: -> { data?(/Back_to TypeOfDisputes/)   }, after: :back_to_type_of_disputes , to: :userTo # "Назад"
          ## Role
          transitions if: -> {data?(/I`m custumer/)              }, after: :choose_type_of_currencies, to: :userTo # "Я покупатель"
          transitions if: -> {data?(/I`m seller/)                }, after: :choose_type_of_currencies, to: :userTo # "Я продавец"
          ## CurrencyTypes
          transitions if: -> {data?(/Criptocurrencies/)          }, after: :choose_specific_currency , to: :userTo # "Криптовалюта"
          transitions if: -> {data?(/Another/)                   }                                   , to: :userTo # ещё не сделано
          ## Currencies
          transitions if: -> {data?(/back_to CurrencyTypes/)     }, after: :back_to_CurrencyTypes    , to: :userTo # "Назад"
          transitions if: -> {data?(/Currency/)                  }, after: :choose_amount            , to: :currency_amount # Выбор определённой валюты
        end
      end
    end
  end
  
  def get_deals_with_comment
    # return nil if $userTo.nil? # если $userTo не определялся. падает если "Отзывы(0)"
    Deal.as_seller($userTo).with_comment
end


def has_comments?
    $userTo = User.find($user.userTo_id)
    deals_with_comment = get_deals_with_comment()
    deals_with_comment.any?
end



########################################################################
def choose_role
  return unless get_userTo_from_new_deal # defining $userTo

  $user.update(role: nil)
  edit_message(B_choose_role[$lg], IM_role.call)
end
#######################################################################

def write_role
  role = $mes.data.split('/').first
  $user.update(role: role == 'I`m custumer' ? 'I`m custumer' : 'I`m seller')
end

def choose_type_of_currencies
  return unless get_userTo_from_new_deal # defining $userTo

  edit_message(B_currency_types[$lg], IM_currency_types.call)

  write_role
end

def back_to_CurrencyTypes
  return unless get_userTo_from_new_deal # defining $userTo

  edit_message(B_currency_types[$lg], IM_currency_types.call)
end

def choose_specific_currency
  return unless get_userTo_from_new_deal # defining $userTo

  edit_message(B_currency_types[$lg], IM_cryptocurrencies.call)
end

######################################################################
def choose_amount
  return unless get_userTo_from_new_deal # defining $userTo

  selected_currency = $mes.data.split('/')[1]

  $user.update(currency: selected_currency)
  send_message("#{B_push_amount_currency[$lg]} <b>#{selected_currency}</b> ")
end

#############################################################
# Disputes #



def userTo_disputes_lost_AND_won
closed_deals = Deal.closed_statuses(DEAL_Closed_Statuses)

dispute_userTo_won  = []
dispute_userTo_lost = []

userTo_disputes = closed_deals.as_seller_OR_as_customer($userTo).each do |deal| 
  if deal.disputes.any? 
    dispute = deal.disputes[0]
    if    dispute.dispute_lost == 'seller_lost'   && deal.seller_id == $userTo.id
      dispute_userTo_lost << dispute
    elsif dispute.dispute_lost == 'custumer_lost' && deal.seller_id == $userTo.id
      dispute_userTo_won  << dispute
    elsif dispute.dispute_lost == 'custumer_lost' && deal.custumer_id == $userTo.id
      dispute_userTo_lost << dispute
    elsif dispute.dispute_lost == 'seller_lost' && deal.custumer_id == $userTo.id
      dispute_userTo_won  << dispute
    end
  end
end
{lost:dispute_userTo_lost,
  won:dispute_userTo_won}
end


def get_userTo_disputes_lost
userTo_disputes_lost_AND_won[:lost]
end

def get_userTo_disputes_won
userTo_disputes_lost_AND_won[:won]
end


def view_type_of_disputes
 return unless get_userTo_from_new_deal # defining $userTo

 userTo_disputes_won  = get_userTo_disputes_won()
 userTo_disputes_lost = get_userTo_disputes_lost()


 edit_message(
  B_disputes_by_userTo[$lg], 
  IM_type_of_disputes.call(
    userTo_disputes_won.size,
    userTo_disputes_lost.size
  ))
end

def disputes_list(type)
texts = []
# 4 варианта 
# dispute.dispute_lost ==  'seller_lost' || 'custumer_lost'
if type == 'wins'
  userTo_disputes_won  = get_userTo_disputes_won()
  userTo_disputes_won.each do |dispute_won|
    text = "Спор по сделке ##{dispute_won.deal.hash_name} \n"
    $deal = dispute_won.deal
    userTo_with_user_role =  if dispute_won.dispute_lost == 'seller_lost'   # если seller проиграл, значит customer выйграл. значит usetTo == сustumer
                              'with_seller' # сам custumer
                            else
                              'with_custumer' # сам seller
                            end
    text += B_deal_verbose.call(userTo_with_user_role)
    text += B_dispute_comment.call(dispute_won)
    texts << text
  end
elsif type == 'losts'
  userTo_disputes_lost = get_userTo_disputes_lost()
  userTo_disputes_lost.each do |dispute_lost|
    text = "Спор по сделке ##{dispute_lost.deal.hash_name} \n"
    $deal = dispute_lost.deal
    userTo_with_user_role =  if dispute_lost.dispute_lost == 'seller_lost'   # если seller проиграл, значит customer выйграл. значит usetTo == сustumer
                              'with_custumer' # сам seller
                            else
                              'with_seller' # сам custumer
                            end
    text += B_deal_verbose.call(userTo_with_user_role)
    text += B_dispute_comment.call(dispute_lost)
    texts << text
  end
end




texts.each_with_index do |text, index|
  send_message(text) if index != texts.size - 1 # промежуточный
  send_message(text, IM_back_to_type_of_disputes.call) if index == texts.size - 1 # последний текст
end
end

def disputes_won
 return unless get_userTo_from_new_deal # defining $userTo
 disputes_list('wins')
end

def disputes_lost
  return unless get_userTo_from_new_deal # defining $userTo

  disputes_list('losts')
end

def back_to_type_of_disputes
  return unless get_userTo_from_new_deal # defining $userTo

  edit_message(B_disputes_by_userTo[$lg], IM_type_of_disputes.call)
end

##########################################
# Comments

def view_comments
  return unless get_userTo_from_new_deal # defining $userTo

  deals_with_comment = get_deals_with_comment()

  

  deals_with_comment.size.times do |i|
    is_last_index = (deals_with_comment.size - 1) == i
    $deal = deals_with_comment[i]
    $customer = User.find($deal.custumer_id)
    if !is_last_index
      send_message(B_comment.call)
    else
      send_message(B_comment.call, IM_back_to_userTo_actions.call)
    end
  end
end


def no_comments
  send_message(B_no_comments[$lg])
end

def to_userTo_from_back
  return unless get_userTo_from_new_deal # defining $userTo

  run_to_userTo

  # send_message(B_userTo_info.call, IM_offer_deal.call)
end
##############################################################
