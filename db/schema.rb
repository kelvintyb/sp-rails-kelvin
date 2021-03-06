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

ActiveRecord::Schema.define(version: 20170219144403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blockades", force: :cascade do |t|
    t.integer  "blocked_id"
    t.integer  "blocker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_blockades_on_blocked_id", using: :btree
    t.index ["blocker_id", "blocked_id"], name: "index_blockades_on_blocker_id_and_blocked_id", unique: true, using: :btree
    t.index ["blocker_id"], name: "index_blockades_on_blocker_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true, using: :btree
    t.index ["friend_user_id"], name: "index_friendships_on_friend_user_id", using: :btree
    t.index ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "subscribed_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["subscribed_id"], name: "index_subscriptions_on_subscribed_id", using: :btree
    t.index ["subscriber_id", "subscribed_id"], name: "index_subscriptions_on_subscriber_id_and_subscribed_id", unique: true, using: :btree
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_user_id"
end
