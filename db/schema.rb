# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.bigserial "post_id", null: false
    t.inet "ip", null: false
    t.index ["ip"], name: "author_ip_idx"
    t.index ["post_id"], name: "author_post_idx"
  end

  create_table "posts", force: :cascade do |t|
    t.bigserial "user_id", null: false
    t.string "title", limit: 200, null: false
    t.text "content", null: false
    t.integer "total", default: 0, null: false
    t.integer "score", default: 0, null: false
    t.float "average", default: 0.0, null: false
    t.index ["average"], name: "post_average_idx"
    t.index ["user_id"], name: "post_user_idx"
  end

  create_table "trails", force: :cascade do |t|
    t.string "url", limit: 50
    t.json "params"
    t.float "milliseconds", default: 0.0, null: false
    t.datetime "created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", limit: 20, null: false
    t.index ["login"], name: "users_login_key", unique: true
  end

  add_foreign_key "authors", "posts", name: "authors_post_id_fkey"
  add_foreign_key "posts", "users", name: "posts_user_id_fkey"
end
