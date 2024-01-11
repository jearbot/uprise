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

ActiveRecord::Schema.define(version: 2024_01_05_005948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: :cascade do |t|
    t.string "phone_number"
    t.string "normalized_phone_number"
    t.string "name"
    t.integer "member_type"
    t.boolean "unsubscribed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "email"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["member_type"], name: "index_members_on_member_type"
    t.index ["normalized_phone_number"], name: "index_members_on_normalized_phone_number", unique: true
  end

  create_table "message_templates", force: :cascade do |t|
    t.string "name"
    t.string "body"
    t.integer "cadence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "sms_messages", force: :cascade do |t|
    t.boolean "outbound"
    t.string "message_body"
    t.integer "segment_count"
    t.string "from_number"
    t.string "to_number"
    t.integer "delivery_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string "token"
    t.string "refresh_token"
    t.string "expires_in"
    t.string "token_type"
    t.string "granted_scopes"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "name"
    t.datetime "locked_at"
    t.integer "failed_attempts", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
