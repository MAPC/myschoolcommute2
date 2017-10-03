#!/bin/bash
# Step 1: Make sure we load the initial app seed file into our local development database with `rake db:reset`
# Step 2: Run this script
# Step 3: Commit the updated seed files to the repo
# Step 4: Push the updated seed files to GitHub and deploy the update to production with `cap production deploy`
# Step 5: On production run `RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:reset` to reset production DB using the new seed file

# Grab the updated information from the remote server
ssh ubuntu@54.243.237.9 << EOF
  echo "COPY (SELECT * FROM survey_child_survey) TO '/tmp/survey_child_survey.csv' DELIMITER ',' CSV HEADER;" | psql -d mysc
  echo "COPY (SELECT * FROM auth_user) TO '/tmp/mysc_users.csv' DELIMITER ',' CSV HEADER;" | psql -d mysc
  echo "COPY (SELECT * FROM survey_surveyset) TO '/tmp/surveys.csv' DELIMITER ',' CSV HEADER;" | psql -d mysc
  echo "COPY (SELECT * FROM survey_school) TO '/tmp/schools.csv' DELIMITER ',' CSV HEADER;" | psql -d mysc
EOF

echo "TRUNCATE surveys, survey_responses, users, schools RESTART IDENTITY;" | psql -d mysc-development


scp ubuntu@54.243.237.9:/tmp/survey_child_survey.csv ./lib/seeds/survey_child_survey.csv
scp ubuntu@54.243.237.9:/tmp/mysc_users.csv ./lib/seeds/mysc_users.csv
scp ubuntu@54.243.237.9:/tmp/surveys.csv ./lib/seeds/surveys.csv
scp ubuntu@54.243.237.9:/tmp/schools.csv ./lib/seeds/schools.csv

rake import:schools
rake import:survey_responses
rake import:survey_sets
rake import:cleanup
rake import:destroy_drafts
rake import:user

rm ./lib/seeds/mysc-seed.dump
pg_dump -h localhost -Fc -o -d mysc-development > ./lib/seeds/mysc-seed.dump
