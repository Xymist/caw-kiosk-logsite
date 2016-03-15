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

ActiveRecord::Schema.define(version: 20160310153928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "kiosks", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_index "visits", ["topic_id"], name: "index_visits_on_topic_id", using: :btree

  add_foreign_key "heartbeats", "kiosks"
end
