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

ActiveRecord::Schema.define(version: 20170314172018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_versions", force: :cascade do |t|
    t.string   "appId"
    t.string   "environment"
    t.integer  "version",     default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "git_commits", force: :cascade do |t|
    t.string   "id_hash"
    t.string   "date"
    t.string   "content"
    t.string   "author"
    t.string   "appid"
    t.string   "environment"
    t.string   "version"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "body_text"
  end

  create_table "labels", force: :cascade do |t|
    t.string   "name"
    t.string   "normalized_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "labels_trello_files", id: false, force: :cascade do |t|
    t.integer "trello_file_id", null: false
    t.integer "label_id",       null: false
    t.index ["trello_file_id", "label_id"], name: "index_labels_trello_files_on_trello_file_id_and_label_id", using: :btree
  end

  create_table "trello_files", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
