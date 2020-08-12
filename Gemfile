source 'https://rubygems.org'
ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'dotenv-rails', :require => 'dotenv/rails-now'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'pg', '~> 0.18'
gem 'activerecord-postgis-adapter'
gem "rgeo"
gem 'rgeo-proj4'
gem 'rgeo-activerecord'
gem "recaptcha", require: "recaptcha/rails"
gem 'webpacker', '~> 4.x'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'pry'
gem 'faker'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'kaminari'
gem 'rgeo-geojson'
gem 'administrate'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'multi_json', '~> 1.11', '>= 1.11.2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootstrap-datepicker-rails', '1.3.1.1'
gem 'devise'
gem 'devise_invitable'
gem 'mailgun_rails'
gem 'pundit'

gem 'scenic'
gem 'sidekiq'

gem 'sentry-raven'

gem 'gettext_i18n_rails'
gem 'gettext', '>=3.0.2', :require => false, :group => :development
gem "gettext_i18n_rails_js", "~> 1.2.0"
gem 'pbkdf2_password_hasher'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

group :test do
  gem 'capybara'
  gem 'launchy'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capistrano', '~> 3.8.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
end

