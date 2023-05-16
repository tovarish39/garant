def get_deals_with_comment
    Deal.as_seller($userTo).with_comment
end


def has_comments?
    deals_with_comment = get_deals_with_comment()
    deals_with_comment.any?
end