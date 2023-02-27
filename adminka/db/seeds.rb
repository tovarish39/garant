# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


seva_telegram_id = 6016837864
my_telegram_id   = 1964112204

seva   = User.find_by(telegram_id:6016837864)
myUser = User.find_by(telegram_id:1964112204)

5.times do
  myUser.deals.create(
    seller_id:   myUser.id,
    custumer_id: seva.id,
    currency:   'aaa',
    amount:     '111',
    conditions: 'zzz',
    hash_name:  'hash_name',
    status:'payed by_custumer'
  )
end