namespace :import do
  desc 'Import seed data'
  task seed: :environment do
    puts "\n== Importing bike and walk spatial networks.
          WARNING: Importing this 1GB file will take a while. =="
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} < lib/seeds/survey_network_bike.sql"
    sh "psql #{Rails.configuration.database_configuration[Rails.env]['database']} < lib/seeds/survey_network_walk.sql"
  end
end
