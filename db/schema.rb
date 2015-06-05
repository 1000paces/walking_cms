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

ActiveRecord::Schema.define(version: 20150605013121) do

  create_table "domains", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   default: 1,     null: false
    t.string   "name",       limit: 255, default: "",    null: false
    t.string   "label",      limit: 255, default: "",    null: false
    t.string   "regex",      limit: 255, default: "",    null: false
    t.integer  "position",   limit: 4
    t.integer  "image_id",   limit: 4
    t.boolean  "secure",     limit: 1,   default: false
    t.string   "snippet",    limit: 255, default: "",    null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "domains", ["name"], name: "index_domains_on_name", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   default: 1,       null: false
    t.string   "label",      limit: 255, default: "",      null: false
    t.string   "title",      limit: 255, default: "",      null: false
    t.string   "permalink",  limit: 255, default: "",      null: false
    t.integer  "position",   limit: 4
    t.integer  "parent_id",  limit: 4
    t.boolean  "secure",     limit: 1,   default: false
    t.string   "snippet",    limit: 255, default: "",      null: false
    t.string   "password",   limit: 255
    t.string   "status",     limit: 255, default: "DRAFT", null: false
    t.boolean  "fluid",      limit: 1,   default: true,    null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",             limit: 255,             null: false
    t.string   "email",             limit: 255,             null: false
    t.string   "first_name",        limit: 255,             null: false
    t.string   "last_name",         limit: 255,             null: false
    t.string   "crypted_password",  limit: 255,             null: false
    t.string   "password_salt",     limit: 255,             null: false
    t.string   "persistence_token", limit: 255,             null: false
    t.integer  "login_count",       limit: 4,   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip",     limit: 255
    t.string   "current_login_ip",  limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_request_at"], name: "index_users_on_last_request_at", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree
  add_index "users", ["persistence_token"], name: "index_users_on_persistence_token", using: :btree

end
