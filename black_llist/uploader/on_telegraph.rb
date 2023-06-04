require 'net/http'
require 'json'
require 'net/http'
require 'nokogiri'
require 'telegram/bot'

require_relative '../requires'

complaint_id = ARGV[0]
user_id   = ARGV[1]

complaint = Complaint.find(complaint_id)
user = BlackListUser.find(user_id)

access_token = '17bfdc2d653bbef801cfbb3c3caff533b4011513e06dfefad55b87178a81'



def create_page(title, content, access_token)
    uri = URI('https://api.telegra.ph/createPage')
    response = Net::HTTP.post_form(uri, {
        'title'        => title, 
        'content'      => content, 
        'access_token' => access_token, 
        'author_url'   => 'https://t.me/keria500', 
        'author_name'  => 'asdf'
        })
    return JSON.parse(response.body)
end


title = 'Заголовок страницы'
content = %Q{[
    {"tag":"p","children":["Приветствие!"]}
}

complaint.photo_ulrs_remote_tmp.each do |url|
    img = %Q{
        ,{"tag":"img", "attrs":{"src":"#{url}"}}
    }
    content << img
end

user_info = "Telegram ID : #{complaint.telegram_id}"
user_info << "\nUsername : @#{complaint.username}" if complaint.username.present?
user_info << "\nFirst_name : #{complaint.first_name}" if complaint.first_name.present?
user_info << "\nLast_name : #{complaint.last_name}" if complaint.last_name.present?

complaint_text = "Complaint : #{complaint.complaint_text}"

content << %Q{
    ,{"tag":"p","children":["#{user_info}"]}
}
content << %Q{
    ,{"tag":"p","children":["#{complaint_text}"]}
}


content << "]"



response = create_page(title, content, access_token)
telegraph_link = response['result']['url']
complaint.update(
    telegraph_link:telegraph_link,
    status:'to_moderator'
)

sended_mes_id = user.cur_mes_id
begin
    # puts "sended_mes_id = #{sended_mes_id}"
    main_bot = Telegram::Bot::Client.new(TOKEN_BOT)


    main_bot.api.edit_message_text(
        chat_id:user.telegram_id, 
        text:"Ваша жалоба #N#{complaint.id} была отправлена на проверку модератором, ожидайте её рассмотрения о результатах вас оповестит бот", 
        message_id:sended_mes_id
    )            
rescue => exception
end



bot = Telegram::Bot::Client.new(TOKEN_BOT_MODERATOR)
moderators = BlackListModerator.all
moderators.each do |moderator|
    mes = bot.api.send_message(
        text:Text.moderator_complaint(user, complaint), 
        chat_id:moderator.telegram_id,
        reply_markup:M::Inline.moderator_complaint(complaint),
        parse_mode:'HTML'
    )
    # puts mes.inspect
    rescue => exception
        puts   exception
        puts   exception.backtrace
end