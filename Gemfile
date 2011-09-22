source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'mysql2'

gem 'bson_ext' # MongoDB Ruby driver
gem 'mongo_mapper'

gem 'mechanize', '2.0.1'
gem 'nokogiri'

# Asset template engines
# gem 'haml'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'log_buddy'
gem 'jquery-rails'
gem 'wordnik_ruby_helpers', '~>0.1.8'

# http://stackoverflow.com/questions/6075961/problem-deploying-rails-3-1-project-to-heroku-could-not-find-a-javascript-runtim
group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
  # gem 'pg'
  # gem 'activerecord-postgresql-adapter'
end

group :test, :development do
  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"
  gem 'factory_girl_rails'
  gem 'colored'
  gem 'autotest'
  gem 'autotest-rails-pure'
end

group :autotest do
  gem 'autotest'
  gem 'autotest-rails-pure'
  # gem 'autotest-growl'
  # gem 'autotest-fsevent'
end