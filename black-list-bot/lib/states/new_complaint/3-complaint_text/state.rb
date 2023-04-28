# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :complaint_text

      event :complaint_text_action, from: :complaint_text do
        transitions if: -> { mes_text?(Button.cancel) }, after: :to_start, to: :start

        transitions if: -> { mes_text? && invalid_complaint_length? }, after: :notify_complaint_length, to: :complaint_text
        transitions if: -> { mes_text?                              }, after: :to_complaint_photos    , to: :complaint_photos
      end
    end
  end
end
