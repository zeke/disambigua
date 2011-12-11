source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'
gem 'bson_ext'
gem 'mongo_mapper'
gem 'mechanize', '2.0.1'
gem 'nokogiri'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'log_buddy'
gem 'jquery-rails'
gem 'wordnik_ruby_helpers', '~>0.1.8'

# http://stackoverflow.com/questions/6075961/problem-deploying-rails-3-1-project-to-heroku-could-not-find-a-javascript-runtime
group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
  # gem 'pg'
  # gem 'activerecord-postgresql-adapter'
end

group :test do
  gem 'rspec', '2.7.0'
  gem 'rspec-rails', '2.7.0'
  gem 'rspec2-rails-views-matchers'
  gem 'webrat'
  gem 'factory_girl', '1.3.3'
  gem 'factory_girl_rails', '1.0.1'
  gem 'colored', '1.2'
  gem 'capybara', '1.0.0'
  gem 'database_cleaner'
  gem 'i18n'
  gem 'autotest', '~>4.4.6'
  gem 'autotest-rails-pure', '~>4.1.2'
  gem 'simplecov', :require => false
end