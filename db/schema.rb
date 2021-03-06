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

ActiveRecord::Schema[7.0].define(version: 20_220_619_214_912) do
  create_table 'recorders', force: :cascade do |t|
    t.integer 'room_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'rooms', force: :cascade do |t|
    t.string 'title'
    t.integer 'owner_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'description'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'title'
    t.integer 'user_id'
    t.integer 'room_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'description'
    t.string 'worker'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'login', null: false
    t.string 'name'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'remember_token_digest'
    t.boolean 'admin_status', default: false
    t.boolean 'invite_status', default: false
    t.index ['login'], name: 'index_users_on_login', unique: true
  end
end
