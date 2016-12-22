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

ActiveRecord::Schema.define(version: 20161222183415) do

  create_table "cells", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "width",                          default: 12,                    null: false
    t.integer  "offset",                         default: 0,                     null: false
    t.integer  "row_id",                                                         null: false
    t.integer  "position",                       default: 0,                     null: false
    t.text     "body",             limit: 65535
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "image"
    t.string   "shape",                          default: "rounded"
    t.string   "breakpoint",                     default: "md"
    t.string   "headline",                       default: ""
    t.boolean  "show_headline",                  default: false
    t.text     "embed_code",       limit: 65535
    t.boolean  "new_window",                     default: true
    t.boolean  "overlay",                        default: false
    t.integer  "variant",                        default: 0
    t.string   "background_color",               default: "rgba(255,255,255,1)"
    t.text     "css",              limit: 65535
    t.string   "public_id"
    t.integer  "image_width"
    t.integer  "image_height"
    t.index ["position"], name: "index_cells_on_position", using: :btree
    t.index ["row_id"], name: "index_cells_on_row_id", using: :btree
  end

  create_table "domains", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    default: 1,     null: false
    t.string   "name",       default: "",    null: false
    t.string   "label",      default: "",    null: false
    t.string   "regex",      default: "",    null: false
    t.integer  "position"
    t.integer  "image_id"
    t.boolean  "secure",     default: false
    t.string   "snippet",    default: "",    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "index_domains_on_name", using: :btree
  end

  create_table "fonts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "family",        default: "Helvetica", null: false
    t.boolean "serif",         default: false,       null: false
    t.integer "min_weight",    default: 100,         null: false
    t.integer "normal_weight", default: 400,         null: false
    t.integer "max_weight",    default: 700,         null: false
  end

  create_table "help_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                    default: "",                null: false
    t.text     "body",       limit: 65535
    t.string   "permalink",                default: "",                null: false
    t.integer  "parent_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "position",                 default: 0,                 null: false
    t.string   "icon",                     default: "HelpTopic::ICON"
    t.index ["parent_id"], name: "index_help_topics_on_parent_id", using: :btree
    t.index ["permalink"], name: "index_help_topics_on_permalink", using: :btree
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                      default: 1,       null: false
    t.string   "label",                        default: "",      null: false
    t.string   "title",                        default: "",      null: false
    t.string   "permalink",                    default: "",      null: false
    t.string   "status",                       default: "DRAFT", null: false
    t.boolean  "secure",                       default: false
    t.string   "snippet",                      default: "",      null: false
    t.string   "password"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "children_count",               default: 0,       null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "headline"
    t.text     "css",            limit: 65535
    t.index ["parent_id"], name: "index_pages_on_parent_id", using: :btree
    t.index ["permalink", "user_id"], name: "index_pages_on_permalink_and_user_id", unique: true, using: :btree
    t.index ["permalink"], name: "index_pages_on_permalink", using: :btree
  end

  create_table "rows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cell_count",               default: 1, null: false
    t.integer  "position",                 default: 0, null: false
    t.integer  "page_id",                              null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "css",        limit: 65535
    t.index ["page_id"], name: "index_rows_on_page_id", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "font_id",                           default: 0,                       null: false
    t.integer  "font_weight",                       default: 400,                     null: false
    t.boolean  "fluid",                             default: true,                    null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "nav_location",                      default: 0
    t.string   "nav_color",                         default: "rgba(55,58,60,1)"
    t.integer  "page_id"
    t.string   "framework",                         default: "b4"
    t.string   "image"
    t.string   "shape"
    t.string   "text_color",                        default: "rgba(0,0,0,1)"
    t.boolean  "overlap",                           default: false
    t.integer  "title_background",                  default: 1
    t.string   "title_background_color",            default: "rgba(255,255,255,0.5)"
    t.string   "public_id"
    t.integer  "image_width"
    t.integer  "image_height"
    t.integer  "x1"
    t.integer  "y1"
    t.integer  "w1"
    t.integer  "h1"
    t.float    "scale",                  limit: 24
    t.index ["page_id"], name: "index_settings_on_page_id", unique: true, using: :btree
    t.index ["user_id", "page_id"], name: "index_settings_on_user_id_and_page_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_settings_on_user_id", unique: true, using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "login",                                       null: false
    t.string   "email",                                       null: false
    t.string   "first_name",                                  null: false
    t.string   "last_name",                                   null: false
    t.string   "crypted_password",                            null: false
    t.string   "password_salt",                               null: false
    t.string   "persistence_token",                           null: false
    t.integer  "login_count",                     default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "css",               limit: 65535
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["last_request_at"], name: "index_users_on_last_request_at", using: :btree
    t.index ["login"], name: "index_users_on_login", using: :btree
    t.index ["persistence_token"], name: "index_users_on_persistence_token", using: :btree
  end

end
