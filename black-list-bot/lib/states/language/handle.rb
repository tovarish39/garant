# frozen_string_literal: true

def view_languages
  Send.mes(Text.lang, M::Inline.lang)
end

def selected_language
  $lg = $mes.data.split('/').first
  $user.update(lang: $lg)
  to_start
end

def to_start
  Send.mes(Text.greet, M::Reply.start)
end
