def get_size_now
    scamer = Scamer.find($user.cur_scamer_id)
    size_now = scamer.photos_size
end

def less_then_max_photos_size?
    get_size_now > MAX_PHOTOS_SIZE
end

def more_then_min_photos_size?
    (get_size_now + 1) < MIN_PHOTOS_SIZE
end


def valid_photos_size?
    more_then_min_photos_size? || less_then_max_photos_size?
end