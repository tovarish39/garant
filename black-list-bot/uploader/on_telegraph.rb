require 'net/http'
require 'json'
require 'net/http'
require 'nokogiri'
require 'telegram/bot'

require_relative '../head/requires'

scamer_id = ARGV[0]
user_id   = ARGV[1]

scamer = Scamer.find(scamer_id)
user = BlackListUser.find(user_id)

access_token = '17bfdc2d653bbef801cfbb3c3caff533b4011513e06dfefad55b87178a81'

# url = URI("https://api.telegra.ph/createAccount?short_name=Sandbox&author_name=Anonymous")


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
# url = %Q{
#     "https://api.telegram.org/file/bot5676653907:AAEHL8SFnepPYxVMT58EHdBHubOx4rehBkY/photos/file_2.jpg"
# }

def get_src ulr
    uri = URI(ulr)
    html = Net::HTTP.get(uri)
    document = Nokogiri::HTML.parse(html)
    imgs        = document.css("#download-preview-image")
    imgs.first['src']        
end

# content = %Q{[
# }
content = %Q{[
    {"tag":"p","children":["Приветствие!"]}
}

scamer.photo_ulrs_remote_tmp.each do |url|
    src = get_src(url)
    img = %Q{
        ,{"tag":"img", "attrs":{"src":"#{src}"}}
    }
    content << img
end

user_info = "Telegram ID : #{scamer.telegram_id}"
user_info << "\nUsername : @#{scamer.username}" if scamer.username.present?
user_info << "\nFirst_name : #{scamer.first_name}" if scamer.first_name.present?
user_info << "\nLast_name : #{scamer.last_name}" if scamer.last_name.present?

complaint_text = "Complaint : #{scamer.complaint_text}"

content << %Q{
    ,{"tag":"p","children":["#{user_info}"]}
}
content << %Q{
    ,{"tag":"p","children":["#{complaint_text}"]}
}


content << "]"



# puts content
response = create_page(title, content, access_token)
# puts response
telegraph_link = response['result']['url']
puts scamer.inspect
scamer.update(
    telegraph_link:telegraph_link,
    status:'to_moderator'
)
# puts 
# puts scamer.inspect

bot = Telegram::Bot::Client.new(TOKEN_BOT_MODERATOR)
moderators = BlackListModerator.all
moderators.each do |moderator|
    mes = bot.api.send_message(
        text:Text.moderator_complaint(user, scamer), 
        chat_id:moderator.telegram_id,
        reply_markup:M::Inline.moderator_complaint(scamer),
        parse_mode:'HTML'
    )
    # puts mes.inspect
    rescue => exception
        puts   exception.backtrace
end




# src = %Q{https://api.telegram.org/file/bot5676653907:AAEHL8SFnepPYxVMT58EHdBHubOx4rehBkY/photos/file_2.jpg}
# img = %Q{
#     ,{"tag":"img", "attrs":{"src":"#{src}"}}
# }
# content = %Q{[
#     {"tag":"p","children":["Hello,+world!"]}
#         #{img}
# ]}

