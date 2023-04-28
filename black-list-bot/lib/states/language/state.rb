# frozen_string_literal: true

class StateMachine
  class_eval do
    include AASM
    aasm do
      state :language

      event :language_action, from: :language do
        transitions if: -> { mes_text? }, after: :view_languages, to: :language
        transitions if: -> { mes_data?(/lg/) }, after: :selected_language, to: :start
      end
    end
  end
end
