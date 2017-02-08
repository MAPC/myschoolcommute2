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

ActiveRecord::Schema.define(version: 20170208214215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "schid"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "district_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schools", ["district_id"], name: "index_schools_on_district_id", using: :btree

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "survey_child_survey", id: false, force: :cascade do |t|
    t.integer  "id",                       null: false
    t.string   "grade",        limit: 255, null: false
    t.string   "to_school",    limit: 255, null: false
    t.string   "dropoff",      limit: 255, null: false
    t.string   "from_school",  limit: 255, null: false
    t.string   "pickup",       limit: 255, null: false
    t.integer  "school_id",                null: false
    t.string   "street",       limit: 255, null: false
    t.string   "cross_st",     limit: 255, null: false
    t.string   "nr_vehicles",  limit: 255, null: false
    t.string   "nr_licenses",  limit: 255, null: false
    t.string   "distance",     limit: 255, null: false
    t.datetime "created",                  null: false
    t.string   "modified",     limit: 255, null: false
    t.string   "st_astext",    limit: 255, null: false
    t.integer  "schid",                    null: false
    t.integer  "shed",                     null: false
    t.string   "current_time", limit: 255, null: false
  end

# Could not dump table "survey_intersection" because of following StandardError
#   Unknown type 'geometry' for column 'geometry'

# Could not dump table "survey_network_bike" because of following StandardError
#   Unknown type 'geometry' for column 'geometry'

# Could not dump table "survey_network_walk" because of following StandardError
#   Unknown type 'geometry' for column 'geometry'

  create_table "survey_responses", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "question"
    t.string   "mode"
    t.integer  "survey_id"
    t.string   "grade_0"
    t.string   "to_school_0"
    t.string   "dropoff_0"
    t.string   "from_school_0"
    t.string   "pickup_0"
    t.string   "nr_vehicles_0"
    t.string   "nr_licenses_0"
    t.string   "grade_1"
    t.string   "to_school_1"
    t.string   "dropoff_1"
    t.string   "from_school_1"
    t.string   "pickup_1"
    t.string   "nr_vehicles_1"
    t.string   "nr_licenses_1"
    t.string   "grade_2"
    t.string   "to_school_2"
    t.string   "dropoff_2"
    t.string   "from_school_2"
    t.string   "pickup_2"
    t.string   "nr_vehicles_2"
    t.string   "nr_licenses_2"
    t.string   "grade_3"
    t.string   "to_school_3"
    t.string   "dropoff_3"
    t.string   "from_school_3"
    t.string   "pickup_3"
    t.string   "nr_vehicles_3"
    t.string   "nr_licenses_3"
    t.string   "grade_4"
    t.string   "to_school_4"
    t.string   "dropoff_4"
    t.string   "from_school_4"
    t.string   "pickup_4"
    t.string   "nr_vehicles_4"
    t.string   "nr_licenses_4"
    t.string   "grade_5"
    t.string   "to_school_5"
    t.string   "dropoff_5"
    t.string   "from_school_5"
    t.string   "pickup_5"
    t.string   "nr_vehicles_5"
    t.string   "nr_licenses_5"
    t.string   "grade_6"
    t.string   "to_school_6"
    t.string   "dropoff_6"
    t.string   "from_school_6"
    t.string   "pickup_6"
    t.string   "nr_vehicles_6"
    t.string   "nr_licenses_6"
    t.string   "grade_7"
    t.string   "to_school_7"
    t.string   "dropoff_7"
    t.string   "from_school_7"
    t.string   "pickup_7"
    t.string   "nr_vehicles_7"
    t.string   "nr_licenses_7"
    t.string   "grade_8"
    t.string   "to_school_8"
    t.string   "dropoff_8"
    t.string   "from_school_8"
    t.string   "pickup_8"
    t.string   "nr_vehicles_8"
    t.string   "nr_licenses_8"
    t.string   "grade_9"
    t.string   "to_school_9"
    t.string   "dropoff_9"
    t.string   "from_school_9"
    t.string   "pickup_9"
    t.string   "nr_vehicles_9"
    t.string   "nr_licenses_9"
    t.string   "grade_10"
    t.string   "to_school_10"
    t.string   "dropoff_10"
    t.string   "from_school_10"
    t.string   "pickup_10"
    t.string   "nr_vehicles_10"
    t.string   "nr_licenses_10"
    t.string   "grade_11"
    t.string   "to_school_11"
    t.string   "dropoff_11"
    t.string   "from_school_11"
    t.string   "pickup_11"
    t.string   "nr_vehicles_11"
    t.string   "nr_licenses_11"
    t.string   "grade_12"
    t.string   "to_school_12"
    t.string   "dropoff_12"
    t.string   "from_school_12"
    t.string   "pickup_12"
    t.string   "nr_vehicles_12"
    t.string   "nr_licenses_12"
    t.string   "grade_13"
    t.string   "to_school_13"
    t.string   "dropoff_13"
    t.string   "from_school_13"
    t.string   "pickup_13"
    t.string   "nr_vehicles_13"
    t.string   "nr_licenses_13"
    t.string   "grade_14"
    t.string   "to_school_14"
    t.string   "dropoff_14"
    t.string   "from_school_14"
    t.string   "pickup_14"
    t.string   "nr_vehicles_14"
    t.string   "nr_licenses_14"
    t.string   "grade_15"
    t.string   "to_school_15"
    t.string   "dropoff_15"
    t.string   "from_school_15"
    t.string   "pickup_15"
    t.string   "nr_vehicles_15"
    t.string   "nr_licenses_15"
    t.string   "grade_16"
    t.string   "to_school_16"
    t.string   "dropoff_16"
    t.string   "from_school_16"
    t.string   "pickup_16"
    t.string   "nr_vehicles_16"
    t.string   "nr_licenses_16"
    t.string   "grade_17"
    t.string   "to_school_17"
    t.string   "dropoff_17"
    t.string   "from_school_17"
    t.string   "pickup_17"
    t.string   "nr_vehicles_17"
    t.string   "nr_licenses_17"
    t.string   "grade_18"
    t.string   "to_school_18"
    t.string   "dropoff_18"
    t.string   "from_school_18"
    t.string   "pickup_18"
    t.string   "nr_vehicles_18"
    t.string   "nr_licenses_18"
    t.string   "grade_19"
    t.string   "to_school_19"
    t.string   "dropoff_19"
    t.string   "from_school_19"
    t.string   "pickup_19"
    t.string   "nr_vehicles_19"
    t.string   "nr_licenses_19"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "survey_responses", ["survey_id"], name: "index_survey_responses_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.date     "begin"
    t.date     "end"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "surveys", ["school_id"], name: "index_surveys_on_school_id", using: :btree

  add_foreign_key "schools", "districts"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "surveys", "schools"
end
