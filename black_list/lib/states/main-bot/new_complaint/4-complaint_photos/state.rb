# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :complaint_photos

      event :complaint_photos_action, from: :complaint_photos do
        transitions if: -> { mes_text?(Button.ready) &&  in_min_limit? }, after: :to_compare_user_id    , to: :compare_user_id
        transitions if: -> { mes_text?(Button.ready) && !in_min_limit? }, after: :notice_min_photos_size, to: :complaint_photos

        transitions if: -> { mes_text?(Button.cancel) }                 , after: :to_start, to: :start

        transitions if: -> { mes_photo? &&  in_max_limit? }             , after: :handle_photo          , to: :complaint_photos
        transitions if: -> { mes_photo? && !in_max_limit? }             , after: :notice_max_photos_size, to: :complaint_photos
      end




      
    end
  end
end
