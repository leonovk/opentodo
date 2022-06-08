

ActiveRecord::Schema[7.0].define(version: 2022_05_29_174437) do
  create_table "recorders", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.boolean "status"
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token_digest"
    t.boolean "admin_status", default: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

end
