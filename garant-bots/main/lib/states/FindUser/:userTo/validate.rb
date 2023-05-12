def get_deals_with_comment_to_user
    Deal.where_user_is_seller($user).with_comment   
end

def has_comments?
    deals_with_comment = get_deals_with_comment_to_user()
    deals_with_comment.any?
end