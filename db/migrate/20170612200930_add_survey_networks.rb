class AddSurveyNetworks < ActiveRecord::Migration[5.0]
  def change
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
  end
end
