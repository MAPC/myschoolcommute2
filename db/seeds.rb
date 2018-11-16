# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

config = Rails.configuration.database_configuration[Rails.env]

host = config['host'] ? "-h #{config['host']}" : ""
user = config['username'] ? "-U #{config['username']}" : ""
#password = config['password'] ? "-P#{config['password']}" : ""

if Rails.env.development? || Rails.env.test?
  User.create({ email: 'admin@user.org', password: 'password', is_admin: true })

  sh "pg_restore -a -O #{host} #{user} -d #{config['database']} -t survey_network_bike -t survey_network_walk -t districts -t surveys -t schools -t survey_responses lib/seeds/mysc-seed.dump" || true
else
  sh "pg_restore -a -O #{host} #{user} -w -d #{config['database']} -t survey_network_bike -t survey_network_walk -t districts -t schools -t surveys -t survey_responses lib/seeds/mysc-seed.dump" || true
end

ActiveRecord::Base.connection.execute("SELECT setval('districts_id_seq', (SELECT MAX(id) FROM districts)+1);")
ActiveRecord::Base.connection.execute("SELECT setval('schools_id_seq', (SELECT MAX(id) FROM schools)+1);")
