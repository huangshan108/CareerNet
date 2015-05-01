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

ActiveRecord::Schema.define(version: 20150501041455) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "account_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "accounts_events", force: :cascade do |t|
    t.integer "account_id"
    t.integer "event_id"
  end

  add_index "accounts_events", ["account_id", "event_id"], name: "index_accounts_events_on_account_id_and_event_id"
  add_index "accounts_events", ["event_id"], name: "index_accounts_events_on_event_id"

  create_table "applications", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "student_id"
    t.integer  "time_slot"
    t.date     "day"
    t.text     "description"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason"
  end

  add_index "appointments", ["staff_id"], name: "index_appointments_on_staff_id"
  add_index "appointments", ["student_id"], name: "index_appointments_on_student_id"

  create_table "colleges", force: :cascade do |t|
    t.string "address"
    t.string "school_name"
    t.string "school_type"
    t.string "school_year"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "address"
    t.integer  "account_id"
    t.text     "brief"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "industry"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "time_start"
    t.datetime "time_end"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "org_name"
    t.string   "job_title"
    t.integer  "yr_exp"
    t.integer  "salary"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "industry_id"
  end

  add_index "experiences", ["student_id"], name: "index_experiences_on_student_id"

  create_table "industries", force: :cascade do |t|
    t.string   "industry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "student_id"
    t.integer  "application_id"
    t.integer  "time_slot"
    t.date     "day"
    t.text     "description"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviews", ["company_id"], name: "index_interviews_on_company_id"
  add_index "interviews", ["student_id"], name: "index_interviews_on_student_id"

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
  end

  create_table "skills_students", force: :cascade do |t|
    t.integer "student_id"
    t.integer "skill_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staffs", ["account_id"], name: "index_staffs_on_account_id"

  create_table "students", force: :cascade do |t|
    t.integer  "major_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "graduation_date"
    t.integer  "college_id"
    t.string   "resume_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "country"
    t.string   "gender"
    t.string   "lastemployer"
    t.string   "city"
    t.string   "state"
    t.text     "notes"
    t.string   "ethnicity"
    t.string   "citizenship"
    t.integer  "years_experience"
    t.integer  "industry"
    t.integer  "base_salary"
    t.string   "title"
    t.integer  "company_id"
  end

  add_index "students", ["major_id"], name: "index_students_on_major_id"

end
