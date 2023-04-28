# frozen_string_literal: true

def notify_account
  Send.mes(Text.clear_account)
end

def to_search_user
  Send.mes(Text.search_user, M::Reply.search_user)
end
