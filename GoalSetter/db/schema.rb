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

ActiveRecord::Schema.define(version: 20150216225112) do

  create_table "comments", force: true do |t|
    t.text     "body",             null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "goal_comments", force: true do |t|
    t.string   "body",       null: false
    t.integer  "author_id",  null: false
    t.integer  "goal_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goal_comments", ["author_id"], name: "index_goal_comments_on_author_id"
  add_index "goal_comments", ["goal_id"], name: "index_goal_comments_on_goal_id"

  create_table "goals", force: true do |t|
    t.string   "name",         null: false
    t.string   "status",       null: false
    t.string   "availability", null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_comments", force: true do |t|
    t.string   "body",       null: false
    t.integer  "author_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_comments", ["author_id"], name: "index_user_comments_on_author_id"
  add_index "user_comments", ["user_id"], name: "index_user_comments_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
