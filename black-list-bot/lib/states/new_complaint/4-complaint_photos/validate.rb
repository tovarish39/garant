def get_size_now
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    return 0 if scamer.nil? # если нету скамера по причине, что пропущено состояние создания скамера
    size_now = scamer.photos_size
end

# def less_then_max_photos_size?
#     get_size_now > MAX_PHOTOS_SIZE
# end

# def more_then_min_photos_size?
#     (get_size_now + 1) < MIN_PHOTOS_SIZE
# end

def in_min_limit?
    get_size_now > MIN_PHOTOS_SIZE
end

def in_max_limit? # ..21
    get_size_now < MAX_PHOTOS_SIZE
end