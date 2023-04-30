# frozen_string_literal: true

module M
  module Inline
    IM = ->(buttons) { Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons) }

    def self.lang
      self::IM.call([
                      [IB.ru, IB.en]
                    ])
    end
  end

  module Reply
    RM = lambda { |*buttons|
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: make_objects(buttons), resize_keyboard: true)
    }
    RM_with_user_request = lambda { |buttons|
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, resize_keyboard: true)
    }

    def self.start
      self::RM.call(
        [Button.make_a_complaint],
        [Button.request_status],
        [Button.account_status],
        [Button.request_history]
      )
    end

    def self.search_user
      self::RM_with_user_request.call([
                                        [{ text: Button.select_user, request_user: { request_id: 111 } }],
                                        [{ text: Button.cancel }]
                                      ])
    end

    def self.user_info
      self::RM.call(
        [Button.verify_potential_scamer],
        [Button.cancel]
      )
    end

    def self.complaint_text
      self::RM.call(
        [Button.cancel]
      )
    end

    def self.complaint_photos
      self::RM.call(
        [Button.ready],
        [Button.cancel]
      )
    end

    def self.compare_user_id
      self::RM.call(
        [Button.skip],
        [Button.cancel]
      )
    end

    def self.make_objects(arr)
      arr.map! { |line| line.map! { |but| { text: but } } }
    end
  end
end
