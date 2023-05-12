class StateMachine
    class_eval do
      include AASM
      aasm do
        state :language
  
        event :language_action, from: :language do
          transitions if: lambda {
                            !$user.lang_viewed
                          }, after: :view_languages, to: :language # один раз приходит сообщение с выбором языка
          transitions if: lambda {
                            text_mes?
                          }, after: :delete_text, to: :language # удаляем любое текстовое сообщение при не выбранном языке
          transitions if: -> { data?(/Выбранный язык/) }, after: :language_selected, to: :start # кликнут "язык"
        end
      end
    end
  end
  
