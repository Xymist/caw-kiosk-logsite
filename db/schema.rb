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

ActiveRecord::Schema.define(version: 20160608143844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advice_pages", force: :cascade do |t|
    t.string   "organisation"
    t.string   "url"
    t.string   "telephone"
    t.string   "details"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "topic"
  end

  create_table "advice_pages_kiosks", id: false, force: :cascade do |t|
    t.integer "advice_page_id"
    t.integer "kiosk_id"
    t.index ["advice_page_id"], name: "index_advice_pages_kiosks_on_advice_page_id", using: :btree
    t.index ["kiosk_id"], name: "index_advice_pages_kiosks_on_kiosk_id", using: :btree
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "form_responses", force: :cascade do |t|
    t.integer  "year"
    t.string   "disability"
    t.string   "sex"
    t.string   "income"
    t.string   "carer"
    t.string   "gp_visits"
    t.boolean  "hospital_time"
    t.string   "problem_type"
    t.string   "referral_type"
    t.boolean  "telephone_usage"
    t.integer  "feedback"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "kiosk_id",        null: false
    t.index ["kiosk_id"], name: "index_form_responses_on_kiosk_id", using: :btree
  end

  create_table "heartbeats", force: :cascade do |t|
    t.integer  "kiosk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kiosk_id"], name: "index_heartbeats_on_kiosk_id", using: :btree
  end

  create_table "hosts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jurisdictions", force: :cascade do |t|
    t.string   "name"
    t.boolean  "telephone"
    t.string   "pbx_server"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jurisdictions_logos", id: false, force: :cascade do |t|
    t.integer "jurisdiction_id"
    t.integer "logo_id"
    t.index ["jurisdiction_id"], name: "index_jurisdictions_logos_on_jurisdiction_id", using: :btree
    t.index ["logo_id"], name: "index_jurisdictions_logos_on_logo_id", using: :btree
  end

  create_table "jurisdictions_users", id: false, force: :cascade do |t|
    t.integer "jurisdiction_id"
    t.integer "user_id"
    t.index ["jurisdiction_id"], name: "index_jurisdictions_users_on_jurisdiction_id", using: :btree
    t.index ["user_id"], name: "index_jurisdictions_users_on_user_id", using: :btree
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "notified"
    t.integer  "jurisdiction_id"
  end

  create_table "log_events", force: :cascade do |t|
    t.string   "log_caller"
    t.string   "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  create_table "logos", force: :cascade do |t|
    t.integer  "image",      null: false
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "location"
    t.integer  "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_topics_on_host_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "admin",                  default: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "approved",               default: false, null: false
    t.index ["approved"], name: "index_users_on_approved", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "visits", force: :cascade do |t|
    t.datetime "time_stamp"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "kiosk_id"
    t.string   "checksum"
    t.index ["checksum"], name: "index_visits_on_checksum", unique: true, using: :btree
    t.index ["time_stamp", "kiosk_id"], name: "index_visits_on_time_stamp_and_kiosk_id", unique: true, using: :btree
    t.index ["topic_id"], name: "index_visits_on_topic_id", using: :btree
  end

  add_foreign_key "heartbeats", "kiosks"
end
