namespace :schoolmap do
  desc "Install dependencies and build React app"
  task install: :environment do
    `#{Rails.root.join('lib', 'external', 'school-map', 'bin', 'install')} #{Rails.root.to_s}`
  end
end
