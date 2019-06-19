# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_19_002514) do

  create_table "leaderboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "host_id"
    t.string "name"
    t.integer "opponent_id"
    t.index ["host_id"], name: "index_rooms_on_host_id"
    t.index ["opponent_id"], name: "index_rooms_on_opponent_id"
  end

  create_table "t_histories", force: :cascade do |t|
    t.integer "tictactoe_id"
    t.text "t0"
    t.text "t1"
    t.text "t2"
    t.text "t3"
    t.text "t4"
    t.text "t5"
    t.text "t6"
    t.text "t7"
    t.text "t8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tictactoe_id"], name: "index_t_histories_on_tictactoe_id"
  end

  create_table "tictactoes", force: :cascade do |t|
    t.integer "room_id"
    t.string "status"
    t.text "boxes"
    t.integer "player"
    t.text "history"
    t.index ["room_id"], name: "index_tictactoes_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ai"
  end

end
