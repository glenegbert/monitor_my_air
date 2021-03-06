# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141202005525) do

  create_table "conditions", force: true do |t|
    t.string "name"
  end

  create_table "conditions_notifications", id: false, force: true do |t|
    t.integer "condition_id"
    t.integer "notification_id"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "zip_code"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

end
