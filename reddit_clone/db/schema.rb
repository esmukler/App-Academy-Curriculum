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

ActiveRecord::Schema.define(version: 20150213204035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id",         null: false
    t.integer  "post_id",           null: false
    t.text     "content",           null: false
    t.integer  "parent_comment_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "post_subs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
  end

  add_index "post_subs", ["post_id"], name: "index_post_subs_on_post_id", using: :btree
  add_index "post_subs", ["sub_id"], name: "index_post_subs_on_sub_id", using: :btree

  create_table "posts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "author_id",  null: false
    t.integer  "sub_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree

  create_table "subs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        null: false
    t.text     "description",  null: false
    t.integer  "moderator_id", null: false
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
