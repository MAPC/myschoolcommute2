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

ActiveRecord::Schema.define(version: 20190114170225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"
  enable_extension "fuzzystrmatch"
  enable_extension "postgis_tiger_geocoder"
  enable_extension "pgrouting"

  create_table "addr", primary_key: "gid", force: :cascade do |t|
    t.bigint  "tlid"
    t.string  "fromhn",    limit: 12
    t.string  "tohn",      limit: 12
    t.string  "side",      limit: 1
    t.string  "zip",       limit: 5
    t.string  "plus4",     limit: 4
    t.string  "fromtyp",   limit: 1
    t.string  "totyp",     limit: 1
    t.integer "fromarmid"
    t.integer "toarmid"
    t.string  "arid",      limit: 22
    t.string  "mtfcc",     limit: 5
    t.string  "statefp",   limit: 2
    t.index ["tlid", "statefp"], name: "idx_tiger_addr_tlid_statefp", using: :btree
    t.index ["zip"], name: "idx_tiger_addr_zip", using: :btree
  end

  create_table "addrfeat", primary_key: "gid", force: :cascade do |t|
    t.bigint   "tlid"
    t.string   "statefp",    limit: 2,                                   null: false
    t.string   "aridl",      limit: 22
    t.string   "aridr",      limit: 22
    t.string   "linearid",   limit: 22
    t.string   "fullname",   limit: 100
    t.string   "lfromhn",    limit: 12
    t.string   "ltohn",      limit: 12
    t.string   "rfromhn",    limit: 12
    t.string   "rtohn",      limit: 12
    t.string   "zipl",       limit: 5
    t.string   "zipr",       limit: 5
    t.string   "edge_mtfcc", limit: 5
    t.string   "parityl",    limit: 1
    t.string   "parityr",    limit: 1
    t.string   "plus4l",     limit: 4
    t.string   "plus4r",     limit: 4
    t.string   "lfromtyp",   limit: 1
    t.string   "ltotyp",     limit: 1
    t.string   "rfromtyp",   limit: 1
    t.string   "rtotyp",     limit: 1
    t.string   "offsetl",    limit: 1
    t.string   "offsetr",    limit: 1
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"line_string"}
    t.index ["the_geom"], name: "idx_addrfeat_geom_gist", using: :gist
    t.index ["tlid"], name: "idx_addrfeat_tlid", using: :btree
    t.index ["zipl"], name: "idx_addrfeat_zipl", using: :btree
    t.index ["zipr"], name: "idx_addrfeat_zipr", using: :btree
  end

  create_table "bg", primary_key: "bg_id", id: :string, limit: 12, force: :cascade, comment: "block groups" do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "blkgrpce", limit: 1
    t.string   "namelsad", limit: 13
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  create_table "county", primary_key: "cntyidfp", id: :string, limit: 5, force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "countyns", limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "csafp",    limit: 3
    t.string   "cbsafp",   limit: 5
    t.string   "metdivfp", limit: 5
    t.string   "funcstat", limit: 1
    t.bigint   "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["countyfp"], name: "idx_tiger_county", using: :btree
    t.index ["gid"], name: "uidx_county_gid", unique: true, using: :btree
  end

  create_table "county_lookup", primary_key: ["st_code", "co_code"], force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "co_code",            null: false
    t.string  "name",    limit: 90
    t.index "soundex((name)::text)", name: "county_lookup_name_idx", using: :btree
    t.index ["state"], name: "county_lookup_state_idx", using: :btree
  end

  create_table "countysub_lookup", primary_key: ["st_code", "co_code", "cs_code"], force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "co_code",            null: false
    t.string  "county",  limit: 90
    t.integer "cs_code",            null: false
    t.string  "name",    limit: 90
    t.index "soundex((name)::text)", name: "countysub_lookup_name_idx", using: :btree
    t.index ["state"], name: "countysub_lookup_state_idx", using: :btree
  end

  create_table "cousub", primary_key: "cosbidfp", id: :string, limit: 10, force: :cascade do |t|
    t.serial   "gid",                                                                   null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "cousubfp", limit: 5
    t.string   "cousubns", limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "cnectafp", limit: 3
    t.string   "nectafp",  limit: 5
    t.string   "nctadvfp", limit: 5
    t.string   "funcstat", limit: 1
    t.decimal  "aland",                                                  precision: 14
    t.decimal  "awater",                                                 precision: 14
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["gid"], name: "uidx_cousub_gid", unique: true, using: :btree
    t.index ["the_geom"], name: "tige_cousub_the_geom_gist", using: :gist
  end

  create_table "direction_lookup", primary_key: "name", id: :string, limit: 20, force: :cascade do |t|
    t.string "abbrev", limit: 3
    t.index ["abbrev"], name: "direction_lookup_abbrev_idx", using: :btree
  end

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

  create_table "edges", primary_key: "gid", force: :cascade do |t|
    t.string   "statefp",    limit: 2
    t.string   "countyfp",   limit: 3
    t.bigint   "tlid"
    t.decimal  "tfidl",                                                        precision: 10
    t.decimal  "tfidr",                                                        precision: 10
    t.string   "mtfcc",      limit: 5
    t.string   "fullname",   limit: 100
    t.string   "smid",       limit: 22
    t.string   "lfromadd",   limit: 12
    t.string   "ltoadd",     limit: 12
    t.string   "rfromadd",   limit: 12
    t.string   "rtoadd",     limit: 12
    t.string   "zipl",       limit: 5
    t.string   "zipr",       limit: 5
    t.string   "featcat",    limit: 1
    t.string   "hydroflg",   limit: 1
    t.string   "railflg",    limit: 1
    t.string   "roadflg",    limit: 1
    t.string   "olfflg",     limit: 1
    t.string   "passflg",    limit: 1
    t.string   "divroad",    limit: 1
    t.string   "exttyp",     limit: 1
    t.string   "ttyp",       limit: 1
    t.string   "deckedroad", limit: 1
    t.string   "artpath",    limit: 1
    t.string   "persist",    limit: 1
    t.string   "gcseflg",    limit: 1
    t.string   "offsetl",    limit: 1
    t.string   "offsetr",    limit: 1
    t.decimal  "tnidf",                                                        precision: 10
    t.decimal  "tnidt",                                                        precision: 10
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"multi_line_string"}
    t.index ["countyfp"], name: "idx_tiger_edges_countyfp", using: :btree
    t.index ["the_geom"], name: "idx_tiger_edges_the_geom_gist", using: :gist
    t.index ["tlid"], name: "idx_edges_tlid", using: :btree
  end

  create_table "faces", primary_key: "gid", force: :cascade do |t|
    t.decimal  "tfid",                                                     precision: 10
    t.string   "statefp00",  limit: 2
    t.string   "countyfp00", limit: 3
    t.string   "tractce00",  limit: 6
    t.string   "blkgrpce00", limit: 1
    t.string   "blockce00",  limit: 4
    t.string   "cousubfp00", limit: 5
    t.string   "submcdfp00", limit: 5
    t.string   "conctyfp00", limit: 5
    t.string   "placefp00",  limit: 5
    t.string   "aiannhfp00", limit: 5
    t.string   "aiannhce00", limit: 4
    t.string   "comptyp00",  limit: 1
    t.string   "trsubfp00",  limit: 5
    t.string   "trsubce00",  limit: 3
    t.string   "anrcfp00",   limit: 5
    t.string   "elsdlea00",  limit: 5
    t.string   "scsdlea00",  limit: 5
    t.string   "unsdlea00",  limit: 5
    t.string   "uace00",     limit: 5
    t.string   "cd108fp",    limit: 2
    t.string   "sldust00",   limit: 3
    t.string   "sldlst00",   limit: 3
    t.string   "vtdst00",    limit: 6
    t.string   "zcta5ce00",  limit: 5
    t.string   "tazce00",    limit: 6
    t.string   "ugace00",    limit: 5
    t.string   "puma5ce00",  limit: 5
    t.string   "statefp",    limit: 2
    t.string   "countyfp",   limit: 3
    t.string   "tractce",    limit: 6
    t.string   "blkgrpce",   limit: 1
    t.string   "blockce",    limit: 4
    t.string   "cousubfp",   limit: 5
    t.string   "submcdfp",   limit: 5
    t.string   "conctyfp",   limit: 5
    t.string   "placefp",    limit: 5
    t.string   "aiannhfp",   limit: 5
    t.string   "aiannhce",   limit: 4
    t.string   "comptyp",    limit: 1
    t.string   "trsubfp",    limit: 5
    t.string   "trsubce",    limit: 3
    t.string   "anrcfp",     limit: 5
    t.string   "ttractce",   limit: 6
    t.string   "tblkgpce",   limit: 1
    t.string   "elsdlea",    limit: 5
    t.string   "scsdlea",    limit: 5
    t.string   "unsdlea",    limit: 5
    t.string   "uace",       limit: 5
    t.string   "cd111fp",    limit: 2
    t.string   "sldust",     limit: 3
    t.string   "sldlst",     limit: 3
    t.string   "vtdst",      limit: 6
    t.string   "zcta5ce",    limit: 5
    t.string   "tazce",      limit: 6
    t.string   "ugace",      limit: 5
    t.string   "puma5ce",    limit: 5
    t.string   "csafp",      limit: 3
    t.string   "cbsafp",     limit: 5
    t.string   "metdivfp",   limit: 5
    t.string   "cnectafp",   limit: 3
    t.string   "nectafp",    limit: 5
    t.string   "nctadvfp",   limit: 5
    t.string   "lwflag",     limit: 1
    t.string   "offset",     limit: 1
    t.float    "atotal"
    t.string   "intptlat",   limit: 11
    t.string   "intptlon",   limit: 12
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["countyfp"], name: "idx_tiger_faces_countyfp", using: :btree
    t.index ["tfid"], name: "idx_tiger_faces_tfid", using: :btree
    t.index ["the_geom"], name: "tiger_faces_the_geom_gist", using: :gist
  end

  create_table "featnames", primary_key: "gid", force: :cascade do |t|
    t.bigint "tlid"
    t.string "fullname",   limit: 100
    t.string "name",       limit: 100
    t.string "predirabrv", limit: 15
    t.string "pretypabrv", limit: 50
    t.string "prequalabr", limit: 15
    t.string "sufdirabrv", limit: 15
    t.string "suftypabrv", limit: 50
    t.string "sufqualabr", limit: 15
    t.string "predir",     limit: 2
    t.string "pretyp",     limit: 3
    t.string "prequal",    limit: 2
    t.string "sufdir",     limit: 2
    t.string "suftyp",     limit: 3
    t.string "sufqual",    limit: 2
    t.string "linearid",   limit: 22
    t.string "mtfcc",      limit: 5
    t.string "paflag",     limit: 1
    t.string "statefp",    limit: 2
    t.index "lower((name)::text)", name: "idx_tiger_featnames_lname", using: :btree
    t.index "soundex((name)::text)", name: "idx_tiger_featnames_snd_name", using: :btree
    t.index ["tlid", "statefp"], name: "idx_tiger_featnames_tlid_statefp", using: :btree
  end

  create_table "geocode_settings", primary_key: "name", id: :text, force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "geocode_settings_default", primary_key: "name", id: :text, force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "loader_lookuptables", primary_key: "lookup_name", id: :text, force: :cascade do |t|
    t.integer "process_order",                   default: 1000,  null: false
    t.text    "table_name"
    t.boolean "single_mode",                     default: true,  null: false
    t.boolean "load",                            default: true,  null: false
    t.boolean "level_county",                    default: false, null: false
    t.boolean "level_state",                     default: false, null: false
    t.boolean "level_nation",                    default: false, null: false
    t.text    "post_load_process"
    t.boolean "single_geom_mode",                default: false
    t.string  "insert_mode",           limit: 1, default: "c",   null: false
    t.text    "pre_load_process"
    t.text    "columns_exclude",                                              array: true
    t.text    "website_root_override"
  end

  create_table "loader_platform", primary_key: "os", id: :string, limit: 50, force: :cascade do |t|
    t.text "declare_sect"
    t.text "pgbin"
    t.text "wget"
    t.text "unzip_command"
    t.text "psql"
    t.text "path_sep"
    t.text "loader"
    t.text "environ_set_command"
    t.text "county_process_command"
  end

  create_table "loader_variables", primary_key: "tiger_year", id: :string, limit: 4, force: :cascade do |t|
    t.text "website_root"
    t.text "staging_fold"
    t.text "data_schema"
    t.text "staging_schema"
  end

  create_table "pagc_gaz", force: :cascade do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_lex", force: :cascade do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_rules", force: :cascade do |t|
    t.text    "rule"
    t.boolean "is_custom", default: true
  end

  create_table "place", primary_key: "plcidfp", id: :string, limit: 7, force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2
    t.string   "placefp",  limit: 5
    t.string   "placens",  limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "cpi",      limit: 1
    t.string   "pcicbsa",  limit: 1
    t.string   "pcinecta", limit: 1
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.bigint   "aland"
    t.bigint   "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["gid"], name: "uidx_tiger_place_gid", unique: true, using: :btree
    t.index ["the_geom"], name: "tiger_place_the_geom_gist", using: :gist
  end

  create_table "place_lookup", primary_key: ["st_code", "pl_code"], force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "pl_code",            null: false
    t.string  "name",    limit: 90
    t.index "soundex((name)::text)", name: "place_lookup_name_idx", using: :btree
    t.index ["state"], name: "place_lookup_state_idx", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",             limit: 200,                               null: false
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
    t.geometry "geometry",         limit: {:srid=>26986, :type=>"point"},    null: false
    t.geometry "shed_05",          limit: {:srid=>26986, :type=>"geometry"}
    t.geometry "shed_10",          limit: {:srid=>26986, :type=>"geometry"}
    t.geometry "shed_15",          limit: {:srid=>26986, :type=>"geometry"}
    t.geometry "shed_20",          limit: {:srid=>26986, :type=>"geometry"}
    t.integer  "muni_id"
    t.integer  "old_id"
    t.index "slug varchar_pattern_ops", name: "survey_school_slug_like", using: :btree
    t.index ["district_id"], name: "survey_school_districtid_id", using: :btree
    t.index ["geometry"], name: "survey_school_geometry_id", using: :gist
    t.index ["schid"], name: "survey_school_schid_key", unique: true, using: :btree
    t.index ["slug"], name: "survey_school_slug", using: :btree
  end

  create_table "secondary_unit_lookup", primary_key: "name", id: :string, limit: 20, force: :cascade do |t|
    t.string "abbrev", limit: 5
    t.index ["abbrev"], name: "secondary_unit_lookup_abbrev_idx", using: :btree
  end

  create_table "state", primary_key: "statefp", id: :string, limit: 2, force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "region",   limit: 2
    t.string   "division", limit: 2
    t.string   "statens",  limit: 8
    t.string   "stusps",   limit: 2,                                     null: false
    t.string   "name",     limit: 100
    t.string   "lsad",     limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.bigint   "aland"
    t.bigint   "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["gid"], name: "uidx_tiger_state_gid", unique: true, using: :btree
    t.index ["stusps"], name: "uidx_tiger_state_stusps", unique: true, using: :btree
    t.index ["the_geom"], name: "idx_tiger_state_the_geom_gist", using: :gist
  end

  create_table "state_lookup", primary_key: "st_code", id: :integer, force: :cascade do |t|
    t.string "name",    limit: 40
    t.string "abbrev",  limit: 3
    t.string "statefp", limit: 2
    t.index ["abbrev"], name: "state_lookup_abbrev_key", unique: true, using: :btree
    t.index ["name"], name: "state_lookup_name_key", unique: true, using: :btree
    t.index ["statefp"], name: "state_lookup_statefp_key", unique: true, using: :btree
  end

  create_table "street_type_lookup", primary_key: "name", id: :string, limit: 50, force: :cascade do |t|
    t.string  "abbrev", limit: 50
    t.boolean "is_hw",             default: false, null: false
    t.index ["abbrev"], name: "street_type_lookup_abbrev_idx", using: :btree
  end

  create_table "survey_network_bike", id: false, force: :cascade do |t|
    t.integer  "ogc_fid",                                        null: false
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.integer  "id",                                             null: false
    t.float    "miles",                                          null: false
    t.integer  "source",                                         null: false
    t.integer  "target",                                         null: false
    t.index ["geometry"], name: "index_survey_network_bike_on_geometry", using: :gist
  end

  create_table "survey_network_walk", id: false, force: :cascade do |t|
    t.integer  "ogc_fid",                                        null: false
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.integer  "id",                                             null: false
    t.float    "miles",                                          null: false
    t.integer  "source",                                         null: false
    t.integer  "target",                                         null: false
    t.index ["geometry"], name: "index_survey_network_walk_on_geometry", using: :gist
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
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.boolean  "in_district",                                          default: false
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

  create_table "tabblock", primary_key: "tabblock_id", id: :string, limit: 16, force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "blockce",  limit: 4
    t.string   "name",     limit: 20
    t.string   "mtfcc",    limit: 5
    t.string   "ur",       limit: 1
    t.string   "uace",     limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  create_table "tract", primary_key: "tract_id", id: :string, limit: 11, force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "name",     limit: 7
    t.string   "namelsad", limit: 20
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "zcta5", primary_key: ["zcta5ce", "statefp"], force: :cascade do |t|
    t.serial   "gid",                                                    null: false
    t.string   "statefp",  limit: 2,                                     null: false
    t.string   "zcta5ce",  limit: 5,                                     null: false
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.string   "partflg",  limit: 1
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
    t.index ["gid"], name: "uidx_tiger_zcta5_gid", unique: true, using: :btree
  end

  create_table "zip_lookup", primary_key: "zip", id: :integer, force: :cascade do |t|
    t.integer "st_code"
    t.string  "state",   limit: 2
    t.integer "co_code"
    t.string  "county",  limit: 90
    t.integer "cs_code"
    t.string  "cousub",  limit: 90
    t.integer "pl_code"
    t.string  "place",   limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_all", id: false, force: :cascade do |t|
    t.integer "zip"
    t.integer "st_code"
    t.string  "state",   limit: 2
    t.integer "co_code"
    t.string  "county",  limit: 90
    t.integer "cs_code"
    t.string  "cousub",  limit: 90
    t.integer "pl_code"
    t.string  "place",   limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_base", primary_key: "zip", id: :string, limit: 5, force: :cascade do |t|
    t.string "state",   limit: 40
    t.string "county",  limit: 90
    t.string "city",    limit: 90
    t.string "statefp", limit: 2
  end

  create_table "zip_state", primary_key: ["zip", "stusps"], force: :cascade do |t|
    t.string "zip",     limit: 5, null: false
    t.string "stusps",  limit: 2, null: false
    t.string "statefp", limit: 2
  end

  create_table "zip_state_loc", primary_key: ["zip", "stusps", "place"], force: :cascade do |t|
    t.string "zip",     limit: 5,   null: false
    t.string "stusps",  limit: 2,   null: false
    t.string "statefp", limit: 2
    t.string "place",   limit: 100, null: false
  end

  add_foreign_key "surveys", "schools"

  create_view "melted_survey_responses",  sql_definition: <<-SQL
      SELECT melted.survey_response_id,
      melted.survey_id,
      melted.distance,
      st_astext(melted.geometry) AS st_astext,
      melted.created,
      melted.modified,
      melted.shed,
      melted.dropoff,
      melted.from_school,
      melted.grade,
      melted.pickup,
      melted.to_school,
      melted.school_id,
      melted.nr_licenses,
      melted.nr_vehicles,
      melted.schid
     FROM ( SELECT survey_responses.id AS survey_response_id,
              survey_responses.survey_id,
              survey_responses.distance,
              survey_responses.geometry,
              survey_responses.created_at AS created,
              survey_responses.updated_at AS modified,
              survey_responses.shed,
              survey_responses.nr_licenses,
              survey_responses.nr_vehicles,
              unnest(ARRAY[survey_responses.dropoff_0, survey_responses.dropoff_1, survey_responses.dropoff_10, survey_responses.dropoff_11, survey_responses.dropoff_12, survey_responses.dropoff_13, survey_responses.dropoff_14, survey_responses.dropoff_15, survey_responses.dropoff_16, survey_responses.dropoff_17, survey_responses.dropoff_18, survey_responses.dropoff_19, survey_responses.dropoff_2, survey_responses.dropoff_3, survey_responses.dropoff_4, survey_responses.dropoff_5, survey_responses.dropoff_6, survey_responses.dropoff_7, survey_responses.dropoff_8, survey_responses.dropoff_9]) AS dropoff,
              unnest(ARRAY[survey_responses.from_school_0, survey_responses.from_school_1, survey_responses.from_school_10, survey_responses.from_school_11, survey_responses.from_school_12, survey_responses.from_school_13, survey_responses.from_school_14, survey_responses.from_school_15, survey_responses.from_school_16, survey_responses.from_school_17, survey_responses.from_school_18, survey_responses.from_school_19, survey_responses.from_school_2, survey_responses.from_school_3, survey_responses.from_school_4, survey_responses.from_school_5, survey_responses.from_school_6, survey_responses.from_school_7, survey_responses.from_school_8, survey_responses.from_school_9]) AS from_school,
              unnest(ARRAY[survey_responses.grade_0, survey_responses.grade_1, survey_responses.grade_10, survey_responses.grade_11, survey_responses.grade_12, survey_responses.grade_13, survey_responses.grade_14, survey_responses.grade_15, survey_responses.grade_16, survey_responses.grade_17, survey_responses.grade_18, survey_responses.grade_19, survey_responses.grade_2, survey_responses.grade_3, survey_responses.grade_4, survey_responses.grade_5, survey_responses.grade_6, survey_responses.grade_7, survey_responses.grade_8, survey_responses.grade_9]) AS grade,
              unnest(ARRAY[survey_responses.pickup_0, survey_responses.pickup_1, survey_responses.pickup_10, survey_responses.pickup_11, survey_responses.pickup_12, survey_responses.pickup_13, survey_responses.pickup_14, survey_responses.pickup_15, survey_responses.pickup_16, survey_responses.pickup_17, survey_responses.pickup_18, survey_responses.pickup_19, survey_responses.pickup_2, survey_responses.pickup_3, survey_responses.pickup_4, survey_responses.pickup_5, survey_responses.pickup_6, survey_responses.pickup_7, survey_responses.pickup_8, survey_responses.pickup_9]) AS pickup,
              unnest(ARRAY[survey_responses.to_school_0, survey_responses.to_school_1, survey_responses.to_school_10, survey_responses.to_school_11, survey_responses.to_school_12, survey_responses.to_school_13, survey_responses.to_school_14, survey_responses.to_school_15, survey_responses.to_school_16, survey_responses.to_school_17, survey_responses.to_school_18, survey_responses.to_school_19, survey_responses.to_school_2, survey_responses.to_school_3, survey_responses.to_school_4, survey_responses.to_school_5, survey_responses.to_school_6, survey_responses.to_school_7, survey_responses.to_school_8, survey_responses.to_school_9]) AS to_school,
              schools.id AS school_id,
              schools.schid
             FROM ((survey_responses
               JOIN surveys ON ((survey_responses.survey_id = surveys.id)))
               JOIN schools ON ((surveys.school_id = schools.id)))
            ORDER BY survey_responses.id) melted
    WHERE (((melted.from_school IS NOT NULL) AND (melted.grade IS NOT NULL)) AND (melted.to_school IS NOT NULL));
  SQL

end
