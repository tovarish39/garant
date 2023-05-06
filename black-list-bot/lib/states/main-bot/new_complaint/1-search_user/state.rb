# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :search_user

      event :search_user_action, from: :search_user do
        transitions if: -> { mes_text?(Button.cancel) }, after: :to_start, to: :start

        # transitions if: -> { is_user_shared? && !user_found? }, after: :not_found          , to: :search_user
        transitions if: -> { is_user_shared? || mes_text? }, after: :to_verify_user_info, to: :verify_user_info
        # transitions if: -> { mes_text? &&       !user_found? }, after: :not_found          , to: :search_user
        transitions if: -> { mes_text? }                   , after: :to_verify_user_info, to: :verify_user_info
      end
    end
  end
end
