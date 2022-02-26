source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'money-rails', '~>1'
gem 'nokogiri', '~>1.13.2'
gem "paperclip", "~> 5.0.0"
gem 'carrierwave', '~> 1.0'
gem 'cloudinary'
gem 'mini_magick'
gem "fog-aws"
gem 'json', '~> 1.8', '< 3'

gem 'scenic'
gem 'kaminari'
gem 'ransack'
gem 'sidekiq'

# accounts and roles
gem 'devise', '~> 4.2'
gem 'cancancan'
gem 'devise_token_auth'
gem 'devise_invitable', '~> 1.7.0'
gem 'omniauth'
gem 'oauth2'

# phone numbers
gem 'date_validator'

gem 'stripe'
gem 'smarter_csv'
gem 'shopify_api'
gem 'raddocs'
gem 'smtpapi'
gem 'config'
gem 'stripe_event'
gem 'paper_trail'
gem 'rest-client'
gem 'pundit'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec-rails', '~> 3.6'
  gem "factory_bot_rails"
  gem "faker", "~> 1.8.4"
  gem 'shoulda-matchers', "~> 3.0.0"
  gem 'pry-byebug'
  gem 'gist'
  # for running acceptance tests with capybara/poltergeist
  gem 'database_cleaner'
  gem 'rspec_api_documentation'
  #gem 'apipie-rails'
  gem 'dotenv-rails'
  gem 'parallel_tests'
end

group :test do
  gem "vcr"
  gem "webmock"
  gem "simplecov", require: false
end

group :production, :staging do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rvm"
  gem "capistrano-passenger"
  gem "capistrano-maintenance", "~> 1.0", require: false
  gem "capistrano-sidekiq"
  gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
  gem "therubyracer"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console', '>= 3.3.0'
  gem 'pry-rails'
  gem 'meta_request'
  gem 'rubocop', '~> 0.51.0', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
