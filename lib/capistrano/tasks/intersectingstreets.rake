namespace :intersectingstreets do
  desc "Install dependencies and build React app"
  task :install do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'intersectingstreets:install'
        end
      end
    end
  end
end
