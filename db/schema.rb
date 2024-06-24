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

ActiveRecord::Schema[7.0].define(version: 2024_06_21_213228) do
  create_table "boards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "boards_gametitle_id"
    t.string "playstyle"
    t.integer "number_of_people"
    t.boolean "openchanger"
    t.integer "boards_tag_id"
    t.datetime "playtime"
    t.text "freetext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "boards_chatrooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_boards_chatrooms_on_board_id"
    t.index ["chatroom_id"], name: "index_boards_chatrooms_on_chatroom_id"
  end

  create_table "boards_chatrooms_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_boards_chatrooms_users_on_chatroom_id"
    t.index ["user_id"], name: "index_boards_chatrooms_users_on_user_id"
  end

  create_table "boards_gametitles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "gametitle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_boards_gametitles_on_board_id"
    t.index ["gametitle_id"], name: "index_boards_gametitles_on_gametitle_id"
  end

  create_table "boards_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "user_id", null: false
    t.datetime "playtime"
    t.text "freetext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_boards_requests_on_board_id"
    t.index ["user_id"], name: "index_boards_requests_on_user_id"
  end

  create_table "boards_tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_boards_tags_on_board_id"
    t.index ["tag_id"], name: "index_boards_tags_on_tag_id"
  end

  create_table "chatrooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "boards_chatrooms_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gametitles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "gamename"
    t.string "game_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permit_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "boards_request_id", null: false
    t.boolean "change_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boards_request_id"], name: "index_permit_requests_on_boards_request_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tagname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "gender", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "icon_image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "boards_chatrooms", "boards"
  add_foreign_key "boards_chatrooms", "chatrooms"
  add_foreign_key "boards_chatrooms_users", "chatrooms"
  add_foreign_key "boards_chatrooms_users", "users"
  add_foreign_key "boards_gametitles", "boards"
  add_foreign_key "boards_gametitles", "gametitles"
  add_foreign_key "boards_requests", "boards"
  add_foreign_key "boards_requests", "users"
  add_foreign_key "boards_tags", "boards"
  add_foreign_key "boards_tags", "tags"
  add_foreign_key "permit_requests", "boards_requests"
end
