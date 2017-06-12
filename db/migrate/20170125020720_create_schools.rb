class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table "schools", force: :cascade do |t|
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
      t.boolean  "survey_active"
      t.geometry "geometry",         limit: {:srid=>0, :type=>"point"},             null: false
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
  end
end
