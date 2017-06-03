# the script takes the following params:
# dbname
# dbuser
# dbpasswd
# ORG_CODE
# DATE1
# DATE2
# WORKDIR
task :generate => :environment do
  puts 'Generating Report'

  filepath = Rails.root.join('lib', 'external_scripts', 'compile.R')

  arguments = [
    'test',
    'test',
    'test',
    '02010078',
    '2012-06-01',
    '2013-06-01',
    'WORKDIR'
  ]

  output = `Rscript --vanilla #{filepath} #{arguments}`
  puts "Output is: " + output
end
