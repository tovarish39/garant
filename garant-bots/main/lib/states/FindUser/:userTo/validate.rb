def get_deals_with_comment
    # return nil if $userTo.nil? # если $userTo не определялся. падает если "Отзывы(0)"
    Deal.as_seller($userTo).with_comment
end


def has_comments?
    $userTo = User.find($user.userTo_id)
    deals_with_comment = get_deals_with_comment()
    deals_with_comment.any?
end