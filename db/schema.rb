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

ActiveRecord::Schema.define(version: 20160419191615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advice_pages", force: :cascade do |t|
    t.string   "organisation"
    t.string   "url"
    t.string   "telephone"
    t.string   "details"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "kiosks"
    t.string   "topic"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "heartbeats", force: :cascade do |t|
    t.integer  "kiosk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "heartbeats", ["kiosk_id"], name: "index_heartbeats_on_kiosk_id", using: :btree

  create_table "hosts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kiosk_topics", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "kiosks", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "notified"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "location"
    t.integer  "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["host_id"], name: "index_topics_on_host_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.datetime "time_stamp"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "kiosk_id"
    t.string   "checksum"
  end

  add_index "visits", ["checksum"], name: "index_visits_on_checksum", unique: true, using: :btree
  add_index "visits", ["time_stamp", "kiosk_id"], name: "index_visits_on_time_stamp_and_kiosk_id", unique: true, using: :btree
  add_index "visits", ["topic_id"], name: "index_visits_on_topic_id", using: :btree

  add_foreign_key "heartbeats", "kiosks"
end
