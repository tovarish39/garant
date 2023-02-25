def income_message 
  if data?()
    return "data = #{$mes.data}"     
  elsif text_mes?()
    return "text = #{$mes.text}"
  end
end