class StateMachine
    class_eval do
      include AASM
      aasm do
        state :profile
  
        event :profile_action, from: :profile do
          transitions if: -> { data?('Extract') }, after: :extracting, to: :start
        end
      end
    end
  end
  
  def view_profile
    Send.mes(B_view_wallet.call, M::Inline.extract)
  end
  
  def empty_wallet
    Send.mes(B_empty_wallet[$lg])
  end
  
  def extracting
    $user.update(wallet: {})
    empty_wallet
    to_start
  end
  