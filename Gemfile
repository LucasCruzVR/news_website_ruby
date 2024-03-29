source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# JSON Web Token
gem 'jwt'
# Gem to access AWS
gem 'aws-sdk-s3', '~> 1.111', '>= 1.111.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem "image_processing", "~> 1.0" #RUN sudo apt-get install libmagickwand-dev TO USE GEM

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', '>= 2.13.0'
  gem 'rspec-rails', '~> 5.0.2'
  gem 'shoulda-matchers', '>= 4.3.0'
  gem 'active_storage_validations'
  gem 'database_cleaner-active_record'
  gem 'airborne'

  gem 'bundler-audit'
  gem 'ruby_audit'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
