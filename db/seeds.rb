# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create({ email: 'admin@user.org', password: 'password', is_admin: true })

if Rails.env.development? || Rails.env.test?
  sh "pg_restore -a -O -d #{Rails.configuration.database_configuration[Rails.env]['database']} -t schools -t survey_network_bike -t survey_network_walk lib/seeds/mysc-seed.dump"
else
  sh "pg_restore -a -O -h db.live.mapc.org -U #{Rails.configuration.database_configuration[Rails.env]['username']} -d #{Rails.configuration.database_configuration[Rails.env]['database']} -t schools -t survey_network_bike -t survey_network_walk lib/seeds/mysc-seed.dump"
end
