namespace :intersectingstreets do
  desc "Install dependencies and build React app"
  task install: :environment do
    `#{Rails.root.join('lib', 'external', 'intersecting-streets', 'bin', 'install')} #{Rails.root.to_s}`
  end
end
