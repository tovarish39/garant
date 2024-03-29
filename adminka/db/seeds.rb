# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

seva_telegram_id = 6_016_837_864
my_telegram_id   = 1_964_112_204

seva   = User.find_by(telegram_id: 6_016_837_864)
myUser = User.find_by(telegram_id: 1_964_112_204)

5.times do
  myUser.deals.create(
    seller_id: seva.id,
    custumer_id: myUser.id,
    currency: 'aaa',
    amount: '111',
    conditions: 'zzz',
    hash_name: 'hash_name',
    status: 'payed by_custumer'
  )
end
