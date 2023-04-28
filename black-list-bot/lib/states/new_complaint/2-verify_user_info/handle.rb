# frozen_string_literal: true

def to_complaint_text
  Send.mes(Text.complaint_text, M::Reply.complaint_text)
end
