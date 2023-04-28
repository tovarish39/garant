# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :start

      event :start_action, from: :start do
        transitions if: -> { mes_text?(Button.make_a_complaint) }, after: :to_search_user, to: :search_user

        transitions if: -> { mes_text?(Button.account_status) && clear_account }, after: :notify_account, to: :start

        transitions if: -> { mes_text?('/start') }, after: :to_start, to: :start
      end
    end
  end
end
