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

ActiveRecord::Schema.define(version: 20170125020722) do

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "households", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "survey_set_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "households", ["survey_set_id"], name: "index_households_on_survey_set_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "schid"
    t.float    "latitude"
    t.decimal  "longitude"
    t.integer  "district_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schools", ["district_id"], name: "index_schools_on_district_id"

  create_table "survey_sets", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "survey_sets", ["school_id"], name: "index_survey_sets_on_school_id"

  create_table "surveys", force: :cascade do |t|
    t.string   "question"
    t.string   "mode"
    t.integer  "household_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "surveys", ["household_id"], name: "index_surveys_on_household_id"

end
