# frozen_string_literal: true

def income_message
  if data?
    "data = #{$mes.data}"
  elsif text_mes?
    "text = #{$mes.text}"
  end
end
