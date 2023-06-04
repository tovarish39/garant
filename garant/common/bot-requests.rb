
module Chat_id
  def self.telegram_id
      $mes.class == Message ? $mes.chat.id : $mes.message.chat.id
  end
end


module Send
  def self.mes text, reply_markup = nil, to: Chat_id
      $bot.api.send_message(chat_id: to.telegram_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
  end 
end

module Delete
  def self.text
      $bot.api.delete_message(chat_id:Chat_id, message_id:$mes.message_id)
  end
  def self.pushed message_id = $mes.message.message_id
      $bot.api.delete_message(chat_id:Chat_id, message_id:message_id)
  end
end

module Edit
  def self.mes text, reply_markup = nil, message_id = nil
      message_id ||= $mes.message.message_id
      $bot.api.edit_message_text(chat_id:Chat_id, message_id:message_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")        
  end
end

module GetChat
  def self.info chat_id
      $bot.api.get_chat(chat_id:chat_id)
  end
end

module Get
  def self.file file_id
      $bot.api.get_file(file_id: file_id)
  end
end









def send_message(text, reply_markup = nil)
  $bot.send_message(chat_id: $chat_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def send_message_to_user(text, to_user, reply_markup = nil)
  $bot.send_message(chat_id: to_user.telegram_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def delete_pushed(message_id = $mes.message.message_id)
  $bot.delete_message(chat_id: $chat_id, message_id: message_id)
end

def delete_text
  begin
    $bot.delete_message(chat_id: $chat_id, message_id: $mes.message_id)
    
  rescue => exception
    
  end
end

def edit_message(text, reply_markup = nil, message_id = nil)
  message_id ||= $mes.message.message_id
  $bot.edit_message_text(chat_id: $chat_id, message_id: message_id, text: text, reply_markup: reply_markup,
                         parse_mode: 'HTML')
end
