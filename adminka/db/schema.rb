# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_15_132025) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.integer "seller_id"
    t.integer "custumer_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency"
    t.string "amount"
    t.string "status"
    t.text "conditions"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "telegram_id"
    t.string "lang"
    t.string "state", default: "start"
    t.string "userTo_id"
    t.string "role"
    t.string "currency"
    t.string "amount"
    t.text "conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lang_viewed"
  end

  add_foreign_key "deals", "users"
end
