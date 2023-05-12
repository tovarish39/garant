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

ActiveRecord::Schema[7.0].define(version: 2023_05_12_172659) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "black_list_moderators", force: :cascade do |t|
    t.string "telegram_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "state_aasm", default: "moderator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cur_complaint_id"
  end

  create_table "black_list_users", force: :cascade do |t|
    t.string "telegram_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "lang"
    t.string "state_aasm"
    t.string "cur_complaint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_self_scamer", default: false
    t.text "justification"
    t.boolean "is_blocked_by_moderator", default: false
    t.string "status"
    t.string "status_by_moderator"
  end

  create_table "complaints", force: :cascade do |t|
    t.bigint "black_list_user_id", null: false
    t.string "telegram_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.string "photos_dir_path"
    t.text "complaint_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "photos_size", default: 0
    t.boolean "is_proofed_by_forwarted_mes", default: false
    t.string "photo_ulrs_remote_tmp", default: [], array: true
    t.string "telegraph_link"
    t.text "explanation_by_moderator"
    t.index ["black_list_user_id"], name: "index_complaints_on_black_list_user_id"
  end

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
    t.string "hash_name"
    t.string "comment"
    t.string "grade"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "disputes", force: :cascade do |t|
    t.bigint "deal_id", null: false
    t.string "created_by_user_id"
    t.string "status"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment_by_moderator"
    t.string "dispute_lost"
    t.json "sended_to_moderators", default: [], array: true
    t.index ["deal_id"], name: "index_disputes_on_deal_id"
  end

  create_table "moderators", force: :cascade do |t|
    t.string "telegram_id"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "aasm_state", default: "moderate"
    t.string "pushed_IB_mes_id"
    t.string "current_dispute_id"
    t.string "pushed_action"
    t.string "rights_status"
    t.string "comment"
  end

  create_table "taken_disputes", force: :cascade do |t|
    t.bigint "moderator_id", null: false
    t.bigint "dispute_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dispute_id"], name: "index_taken_disputes_on_dispute_id"
    t.index ["moderator_id"], name: "index_taken_disputes_on_moderator_id"
  end

  create_table "used_hashes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "telegram_id"
    t.string "lang"
    t.string "aasm_state", default: "start"
    t.string "userTo_id"
    t.string "role"
    t.string "currency"
    t.string "amount"
    t.text "conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lang_viewed"
    t.string "mes_ids_to_edit", default: [], array: true
    t.string "cur_deal_id"
    t.string "hash_name"
    t.json "wallet", default: {}
    t.string "with_bot_status", default: "member"
  end

  add_foreign_key "complaints", "black_list_users"
  add_foreign_key "deals", "users"
  add_foreign_key "disputes", "deals"
  add_foreign_key "taken_disputes", "disputes"
  add_foreign_key "taken_disputes", "moderators"
end
