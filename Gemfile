source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'awesome_print'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm'
end

group :test do
  gem 'capybara'
  gem 'rspec-retry'
  gem "chromedriver-helper"
  gem 'ci_reporter'
  gem 'ci_reporter_rspec'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'guard-rails', '~> 0.7.2'
  gem 'guard-rspec', '~> 4.7.2'
  gem 'guard-spring'
  gem 'simplecov', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'redis'
gem 'slim'
gem 'slim-rails'
gem 'devise'
gem 'gon'
gem 'carrierwave'

gem 'mysql2'
gem 'thinking-sphinx', '~> 3.1.0'

gem 'aasm'
gem 'mini_magick'

gem "oxymoron", git: "https://github.com/storuky/oxymoron.git", branch: :master

gem 'oj'
gem 'oj_mimic_json'
gem 'file_validators'
gem 'active_model_serializers', '>= 0.9.2'
gem 'rest-client'
gem 'kaminari'
gem 'rolify'
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'
