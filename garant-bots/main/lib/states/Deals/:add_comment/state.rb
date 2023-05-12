class StateMachine
    class_eval do
      include AASM
      aasm do
        state :add_comment
  

        event :add_comment_action, from: :add_comment do
          transitions if: -> { data?('skip_comment') }, after: :delete_pushed, to: :deals_menu
          transitions if: -> { text_mes? }, after: :handle_comment, to: :deals_menu
        end
      end
    end
  end
  
