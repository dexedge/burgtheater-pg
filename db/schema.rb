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

ActiveRecord::Schema.define(version: 2018_10_21_191755) do

  create_table "authors", force: :cascade do |t|
    t.string "lastname"
    t.string "firstnames"
    t.integer "birth"
    t.integer "death"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "composers", force: :cascade do |t|
    t.string "lastname"
    t.string "firstnames"
    t.integer "birth"
    t.integer "death"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.string "receipts"
    t.string "kind"
    t.boolean "zinzendorf"
    t.boolean "double"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_works", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", nil], name: "index_events_works_on_event_id_and_student_id", unique: true
  end

  create_table "performances", force: :cascade do |t|
    t.integer "event_id"
    t.integer "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "work_id"], name: "index_performances_on_event_id_and_work_id", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string "title"
    t.string "genre"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "writings", force: :cascade do |t|
    t.integer "author_id"
    t.integer "work_id"
    t.string "function"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "work_id"], name: "index_writings_on_author_id_and_work_id", unique: true
  end

end
