# the script takes the following params:
# dbname
# dbuser
# dbpasswd
# ORG_CODE
# DATE1
# DATE2
# WORKDIR
task :generate => :environment do
  puts GenerateReportService.new.perform
end
