require 'csv'

namespace :import do
  desc 'Import seed data'
  task seed: :environment do
    puts "\n== Importing bike and walk spatial networks.
          WARNING: Importing this 1GB file will take a while. =="
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} < lib/seeds/survey_network_bike.sql"
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} < lib/seeds/survey_network_walk.sql"
    sh "psql #{Rails.configuration.database_configuration['test']['database']} < lib/seeds/survey_network_bike.sql"
    sh "psql #{Rails.configuration.database_configuration['test']['database']} < lib/seeds/survey_network_walk.sql"
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} < lib/seeds/schools.sql"
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} -c 'ALTER TABLE survey_school RENAME TO schools;'"
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} -c 'ALTER TABLE schools RENAME districtid_id TO district_id;'"
    sh "psql #{Rails.configuration.database_configuration['test']['database']} < lib/seeds/schools.sql"
    sh "psql #{Rails.configuration.database_configuration['test']['database']} -c 'ALTER TABLE survey_school RENAME TO schools;'"
    sh "psql #{Rails.configuration.database_configuration['test']['database']} -c 'ALTER TABLE schools RENAME districtid_id TO district_id;'"
  end

  desc 'Import districts'
  task districts: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'districts.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each_with_index do |row, index|
      a = District.new
      a.distname = row['distname']
      a.geometry = row['geometry']
      a.slug = row['slug']
      a.startgrade = row['startgrade']
      a.endgrade = row['endgrade']
      a.distcode4 = row['distcode4']
      a.distcode8 = row['distcode8']
      a.districtid_id = row['districtid']
      a.save
    end
  end

  desc 'Import schools' 
  task schools: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'schools.csv')).encode("UTF-8","Windows-1252"); nil
    csv = CSV.parse(csv_text, headers: true, encoding: 'Windows-1252')
    School.skip_callback(:save, :after, :update_sheds)
    csv.each_with_index do |row, index|
      a = School.new
      a.name = row['name']
      a.schid = row['schid']
      a.geometry = row['geometry']
      a.shed_05 = row['shed_05']
      a.save!
      a.shed_10 = row['shed_10']
      a.save!
      a.shed_15 = row['shed_15']
      a.save!
      a.shed_20 = row['shed_20']
      a.save!
      a.district = District.find_by_districtid_id(row['districtid_id'])
      a.save!
    end
  end
end
