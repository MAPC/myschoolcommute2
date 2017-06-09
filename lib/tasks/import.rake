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
      a.id = row['districtid']
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

  # todo:
  # get surveys from survey_set begin/end dates - these determine how to assign ids and pull apart survey responses
  # surveysetdata.each {|set| survey_response=SurveyResponse.where(before < set.before)...; survey_response.survey=#blahblah create  }
  desc 'Import survey responses'
  task survey_responses: :environment do
    puts 'WARNING: This will APPEND data rather than sync. This should only be run on a blank database. Pausing 10 seconds...'
    sleep 10
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'survey_responses.csv')); nil
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

    SurveyResponse.connection
    SurveyResponse.skip_callback(:save, :after, :find_intersecting_shed)
    SurveyResponse.skip_callback(:save, :after, :calculate_distance)
    csv.group_by{|row| row['survey_id']}.values.each do |group|
      # 16 = survey_id
      survey_response = SurveyResponse.new
      school = School.find(group[0]['school_id'])
      survey = Survey.new({school:school})
      survey.save!(validate: false)
      puts "Survey ID #{survey.id}"
      survey_response.nr_vehicles = group[0]['nr_vehicles']
      survey_response.nr_licenses = group[0]['nr_licenses']
      survey_response.survey = survey
      survey_response.geometry = group[0]['st_astext']
      survey_response.distance = group[0]['distance']
      survey_response.shed = group[0]['shed']
      survey_response.created_at = group[0]['created']

      group.each_with_index do |row, index|
        survey_response["grade_#{index}"] = row['grade']
        survey_response["to_school_#{index}"] = row['to_school']
        survey_response["dropoff_#{index}"] = row['dropoff']
        survey_response["from_school_#{index}"] = row['from_school']
        survey_response["pickup_#{index}"] = row['pickup']
      end

      survey_response.save
      puts "Saved Survey Response #{survey_response.id} with Survey #{survey_response.survey.id}"
    end


  end

  desc 'Import survey set distinctions'
  task survey_sets: :environment do
    puts 'WARNING: This will APPEND data rather than sync. This should only be run on a blank database. Pausing 10 seconds...'
    sleep 10
    csv_test = File.read(Rails.root.join('lib', 'seeds', 'surveys.csv')); nil
    csv = CSV.parse(csv_test, headers: true, encoding: 'ISO-8859-1')

    SurveyResponse.connection
    SurveyResponse.skip_callback(:save, :after, :find_intersecting_shed)
    SurveyResponse.skip_callback(:save, :after, :calculate_distance)

    puts "Assigning correct survey set ids"
    csv.each do |set|
      school = School.find(set['school_id'])
      survey = Survey.create({begin: set['begin'], end: set['end'], school: school})
      upper_bound = Date.parse(set['end']) + 1 # for whatever reason, the upper bounds is increased by a day
      responses = SurveyResponse.joins(:survey).where("survey_responses.created_at >= '#{set['begin']}' AND survey_responses.created_at <= '#{upper_bound}' AND surveys.school_id= #{school.id} ")
      puts "Responses count for #{school.name} in #{school.district.distname}: #{responses.length}"
      responses.each do |response|
        response.survey_id = survey.id
        response.save
      end
    end
  end

  desc 'Remove childless surveys'
  task cleanup: :environment do
    Survey.all.each do |survey|
      if survey.survey_responses.count == 0
        survey.destroy
      end
    end
  end

  desc 'Remove survey response orphans'
  task cleanup: :environment do
    Survey.all.each do |survey|
      if survey.survey_responses.count == 0
        survey.destroy
      end
    end
  end
end
