# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :complaint_photos

      event :complaint_photos_action, from: :complaint_photos do
        transitions if: -> { mes_text?(Button.cancel) }, after: :to_start, to: :start

        transitions if: -> { mes_photo? &&  valid_photos_size? }, after: :handle_photo      , to: :complaint_photos
        transitions if: -> { mes_photo? && !valid_photos_size? }, after: :notice_photos_size, to: :complaint_photos
      end
    end
  end
end
