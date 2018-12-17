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

ActiveRecord::Schema.define(version: 2018_12_17_002421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.text "lastname"
    t.text "firstnames"
    t.bigint "birth"
    t.bigint "death"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sortable_name"
    t.string "slug"
    t.index ["slug"], name: "index_authors_on_slug", unique: true
  end

  create_table "composers", force: :cascade do |t|
    t.text "lastname"
    t.text "firstnames"
    t.bigint "birth"
    t.bigint "death"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.index ["slug"], name: "index_composers_on_slug", unique: true
  end

  create_table "composings", force: :cascade do |t|
    t.bigint "composer_id"
    t.bigint "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["composer_id", "work_id"], name: "idx_17314_index_composings_on_composer_id_and_work_id", unique: true
  end

  create_table "events", id: :bigint, default: nil, force: :cascade do |t|
    t.date "date"
    t.text "receipts"
    t.text "kind"
    t.boolean "zinzendorf"
    t.boolean "double"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "events_works", id: false, force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id", "work_id"], name: "idx_17275_index_performances_on_event_id_and_work_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.text "title"
    t.text "genre"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sortable_title"
    t.string "slug"
    t.index ["slug"], name: "index_works_on_slug", unique: true
  end

  create_table "writings", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "work_id"
    t.text "function"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "credited_author", default: false, null: false
    t.index ["author_id", "work_id"], name: "idx_17296_index_writings_on_author_id_and_work_id", unique: true
  end

end
