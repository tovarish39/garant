

deals1 = [1, 2]
deals2 = [3, 4]

def first_method(current_deals)
  yield(current_deals, 'action')
end

first_method(deals1) { |_current_deals, action| deals1.each { puts action } }
