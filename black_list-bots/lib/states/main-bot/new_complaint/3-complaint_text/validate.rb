# frozen_string_literal: true

def more_then_max_length?
  length = $mes.text.size
  length > MAX_LENGTH_COMPLAINT_TEXT
end

def less_then_min_length?
  length = $mes.text.size
  length < MIN_LENGTH_COMPLAINT_TEXT
end

def invalid_complaint_length?
  more_then_max_length? || less_then_min_length?
end
