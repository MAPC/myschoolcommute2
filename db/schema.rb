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

ActiveRecord::Schema.define(version: 20170606203348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "pgrouting"

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "distname"
    t.string   "slug"
    t.string   "startgrade"
    t.string   "endgrade"
    t.string   "distcode4"
    t.string   "distcode8"
    t.integer  "districtid_id"
    t.geometry "geometry",      limit: {:srid=>26986, :type=>"geometry"}
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "schools", id: :integer, default: -> { "nextval('survey_school_id_seq'::regclass)" }, force: :cascade do |t|
    t.string   "name",             limit: 200,                                    null: false
    t.string   "slug",             limit: 200
    t.string   "schid",            limit: 8
    t.string   "address",          limit: 150
    t.string   "town_mail",        limit: 25
    t.string   "town",             limit: 25
    t.string   "state",            limit: 2
    t.string   "zip",              limit: 10
    t.string   "principal",        limit: 50
    t.string   "phone",            limit: 15
    t.string   "fax",              limit: 15
    t.string   "grades",           limit: 70
    t.string   "schl_type",        limit: 3
    t.integer  "district_id"
    t.text     "survey_incentive"
    t.boolean  "survey_active",                                                   null: false
    t.geometry "geometry",         limit: {:srid=>26986, :type=>"point"},         null: false
    t.geometry "shed_05",          limit: {:srid=>26986, :type=>"multi_polygon"}
    t.geometry "shed_10",          limit: {:srid=>26986, :type=>"multi_polygon"}
    t.geometry "shed_15",          limit: {:srid=>26986, :type=>"multi_polygon"}
    t.geometry "shed_20",          limit: {:srid=>26986, :type=>"multi_polygon"}
    t.integer  "muni_id"
    t.index "slug varchar_pattern_ops", name: "survey_school_slug_like", using: :btree
    t.index ["district_id"], name: "survey_school_districtid_id", using: :btree
    t.index ["geometry"], name: "survey_school_geometry_id", using: :gist
    t.index ["schid"], name: "survey_school_schid_key", unique: true, using: :btree
    t.index ["slug"], name: "survey_school_slug", using: :btree
  end

  create_table "survey_network_bike", id: false, force: :cascade do |t|
    t.integer  "ogc_fid",                                        null: false
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.integer  "id",                                             null: false
    t.float    "miles",                                          null: false
    t.integer  "source",                                         null: false
    t.integer  "target",                                         null: false
  end

  create_table "survey_network_walk", id: false, force: :cascade do |t|
    t.integer  "ogc_fid",                                        null: false
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.integer  "id",                                             null: false
    t.float    "miles",                                          null: false
    t.integer  "source",                                         null: false
    t.integer  "target",                                         null: false
  end

  create_table "survey_responses", force: :cascade do |t|
    t.geometry "geometry",       limit: {:srid=>4326, :type=>"point"}
    t.string   "question"
    t.string   "mode"
    t.integer  "shed"
    t.float    "distance"
    t.integer  "survey_id"
    t.string   "grade_0"
    t.string   "to_school_0"
    t.string   "dropoff_0"
    t.string   "from_school_0"
    t.string   "pickup_0"
    t.string   "grade_1"
    t.string   "to_school_1"
    t.string   "dropoff_1"
    t.string   "from_school_1"
    t.string   "pickup_1"
    t.string   "grade_2"
    t.string   "to_school_2"
    t.string   "dropoff_2"
    t.string   "from_school_2"
    t.string   "pickup_2"
    t.string   "grade_3"
    t.string   "to_school_3"
    t.string   "dropoff_3"
    t.string   "from_school_3"
    t.string   "pickup_3"
    t.string   "grade_4"
    t.string   "to_school_4"
    t.string   "dropoff_4"
    t.string   "from_school_4"
    t.string   "pickup_4"
    t.string   "grade_5"
    t.string   "to_school_5"
    t.string   "dropoff_5"
    t.string   "from_school_5"
    t.string   "pickup_5"
    t.string   "grade_6"
    t.string   "to_school_6"
    t.string   "dropoff_6"
    t.string   "from_school_6"
    t.string   "pickup_6"
    t.string   "grade_7"
    t.string   "to_school_7"
    t.string   "dropoff_7"
    t.string   "from_school_7"
    t.string   "pickup_7"
    t.string   "grade_8"
    t.string   "to_school_8"
    t.string   "dropoff_8"
    t.string   "from_school_8"
    t.string   "pickup_8"
    t.string   "grade_9"
    t.string   "to_school_9"
    t.string   "dropoff_9"
    t.string   "from_school_9"
    t.string   "pickup_9"
    t.string   "grade_10"
    t.string   "to_school_10"
    t.string   "dropoff_10"
    t.string   "from_school_10"
    t.string   "pickup_10"
    t.string   "grade_11"
    t.string   "to_school_11"
    t.string   "dropoff_11"
    t.string   "from_school_11"
    t.string   "pickup_11"
    t.string   "grade_12"
    t.string   "to_school_12"
    t.string   "dropoff_12"
    t.string   "from_school_12"
    t.string   "pickup_12"
    t.string   "grade_13"
    t.string   "to_school_13"
    t.string   "dropoff_13"
    t.string   "from_school_13"
    t.string   "pickup_13"
    t.string   "grade_14"
    t.string   "to_school_14"
    t.string   "dropoff_14"
    t.string   "from_school_14"
    t.string   "pickup_14"
    t.string   "grade_15"
    t.string   "to_school_15"
    t.string   "dropoff_15"
    t.string   "from_school_15"
    t.string   "pickup_15"
    t.string   "grade_16"
    t.string   "to_school_16"
    t.string   "dropoff_16"
    t.string   "from_school_16"
    t.string   "pickup_16"
    t.string   "grade_17"
    t.string   "to_school_17"
    t.string   "dropoff_17"
    t.string   "from_school_17"
    t.string   "pickup_17"
    t.string   "grade_18"
    t.string   "to_school_18"
    t.string   "dropoff_18"
    t.string   "from_school_18"
    t.string   "pickup_18"
    t.string   "grade_19"
    t.string   "to_school_19"
    t.string   "dropoff_19"
    t.string   "from_school_19"
    t.string   "pickup_19"
    t.string   "nr_vehicles"
    t.string   "nr_licenses"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.date     "begin"
    t.date     "end"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_surveys_on_school_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
    t.boolean  "is_district",            default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "surveys", "schools"
end
