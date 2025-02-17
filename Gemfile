source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.3'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'jsbundling-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'pry', '~> 0.14.2'
gem 'pry-rails', '~> 0.3.9', require: 'pry-rails/console'
gem 'sidekiq', '~> 7.2'
gem 'google-apis-calendar_v3', '~> 0.36.0'
gem 'googleauth', '~> 1.9', '>= 1.9.1'
gem 'twilio-ruby', '~> 6.9'
gem 'dotenv', '~> 2.8', '>= 2.8.1'
gem 'securerandom', '~> 0.3.1'
gem 'sendgrid-ruby', '~> 6.7'
gem 'bootstrap', '~> 5.3', '>= 5.3.2'
gem 'faker', '~> 3.2', '>= 3.2.2'
gem 'phony_rails', '~> 0.15.0'
gem 'paranoia', '~> 2.6', '>= 2.6.3'
gem 'annotate', '~> 3.2'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'kaminari-bootstrap', '~> 3.0', '>= 3.0.1'
gem 'jquery-rails', '~> 4.6'
gem 'clockwork', '~> 3.0', '>= 3.0.2'
gem 'toastr-rails', '~> 1.0', '>= 1.0.3'
gem 'active_model_serializers', '~> 0.10.14'
gem 'httparty', '~> 0.19.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec', '~> 3.12'
  gem 'rspec-rails', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "importmap-rails", "~> 1.2"
