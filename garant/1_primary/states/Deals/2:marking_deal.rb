class StateMachine
    class_eval do
      include AASM
      aasm do
        state :marking_deal
  
        event :marking_deal_action, from: :marking_deal do
          transitions if: -> { data?(/stars/) }, after: :to_add_comment, to: :add_comment
        end
      end
    end
  end
  

  def to_add_comment
    $deal = get_deal
    grade = $mes.data.split('/').first
  
    $deal.update(grade: grade)
    $user.update(cur_deal_id: $deal.id)
  
    send_message(B_add_comment[$lg], IM_add_comment.call)
  end
  