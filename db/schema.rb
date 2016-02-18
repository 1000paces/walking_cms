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

ActiveRecord::Schema.define(version: 20160218030348) do

  create_table "cells", force: :cascade do |t|
    t.integer  "width",         limit: 4,     default: 12,        null: false
    t.integer  "offset",        limit: 4,     default: 0,         null: false
    t.integer  "row_id",        limit: 4,                         null: false
    t.integer  "position",      limit: 4,     default: 0,         null: false
    t.text     "body",          limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "image",         limit: 255
    t.string   "shape",         limit: 255,   default: "rounded"
    t.string   "breakpoint",    limit: 255,   default: "md"
    t.boolean  "border",                      default: false
    t.string   "headline",      limit: 255,   default: ""
    t.boolean  "show_headline",               default: false
    t.text     "embed_code",    limit: 65535
  end

  add_index "cells", ["position"], name: "index_cells_on_position", using: :btree
  add_index "cells", ["row_id"], name: "index_cells_on_row_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   default: 1,     null: false
    t.string   "name",       limit: 255, default: "",    null: false
    t.string   "label",      limit: 255, default: "",    null: false
    t.string   "regex",      limit: 255, default: "",    null: false
    t.integer  "position",   limit: 4
    t.integer  "image_id",   limit: 4
    t.boolean  "secure",                 default: false
    t.string   "snippet",    limit: 255, default: "",    null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "domains", ["name"], name: "index_domains_on_name", using: :btree

  create_table "fonts", force: :cascade do |t|
    t.string  "family",        limit: 255, default: "Helvetica", null: false
    t.boolean "serif",                     default: false,       null: false
    t.integer "min_weight",    limit: 4,   default: 100,         null: false
    t.integer "normal_weight", limit: 4,   default: 400,         null: false
    t.integer "max_weight",    limit: 4,   default: 700,         null: false
  end

  create_table "help_topics", force: :cascade do |t|
    t.string   "title",      limit: 255,   default: "",                null: false
    t.text     "body",       limit: 65535
    t.string   "permalink",  limit: 255,   default: "",                null: false
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "position",   limit: 4,     default: 0,                 null: false
    t.string   "icon",       limit: 255,   default: "HelpTopic::ICON"
  end

  add_index "help_topics", ["parent_id"], name: "index_help_topics_on_parent_id", using: :btree
  add_index "help_topics", ["permalink"], name: "index_help_topics_on_permalink", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "user_id",        limit: 4,   default: 1,       null: false
    t.string   "label",          limit: 255, default: "",      null: false
    t.string   "title",          limit: 255, default: "",      null: false
    t.string   "permalink",      limit: 255, default: "",      null: false
    t.string   "status",         limit: 255, default: "DRAFT", null: false
    t.boolean  "secure",                     default: false
    t.string   "snippet",        limit: 255, default: "",      null: false
    t.string   "password",       limit: 255
    t.integer  "position",       limit: 4
    t.integer  "parent_id",      limit: 4
    t.integer  "children_count", limit: 4,   default: 0,       null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree

  create_table "rows", force: :cascade do |t|
    t.integer  "cell_count", limit: 4, default: 1, null: false
    t.integer  "position",   limit: 4, default: 0, null: false
    t.integer  "page_id",    limit: 4,             null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "rows", ["page_id"], name: "index_rows_on_page_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "font_id",      limit: 4,   default: 0,                  null: false
    t.integer  "font_weight",  limit: 4,   default: 400,                null: false
    t.boolean  "fluid",                    default: true,               null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "nav_location", limit: 4,   default: 0
    t.string   "nav_color",    limit: 255, default: "rgba(55,58,60,1)"
    t.integer  "page_id",      limit: 4
  end

  add_index "settings", ["page_id"], name: "index_settings_on_page_id", unique: true, using: :btree
  add_index "settings", ["user_id", "page_id"], name: "index_settings_on_user_id_and_page_id", unique: true, using: :btree
  add_index "settings", ["user_id"], name: "index_settings_on_user_id", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
