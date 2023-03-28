# frozen_string_literal: true

source 'https://rubygems.org'

# loads environment variables
gem 'dotenv'
# logger based on slf4j
gem 'logging'
# rack web server
gem 'puma'
# webserver default interface
gem 'rack'
# task manager
gem 'rake'
# micro web framework
gem 'sinatra'
# additional libs within Sinatra
gem 'sinatra-contrib'
# random number generation
gem 'sysrandom'
# sqlite database support
gem 'sqlite3'
# orm
gem 'activerecord'
# database migrations
# gem 'otr-activerecord' # or
# gem 'standalone_migrations' # or tune up your own active-record-based manager (config/db/database.rake)

group :test do
  # object generation
  gem 'factory_bot'
  # random values
  gem 'faker'
  # test methods for rack apps
  gem 'rack-test'
  # test framework
  gem 'rspec'
  # e2e tests
  gem 'selenium-cucumber'
  gem 'selenium-webdriver'
end

group :development do
  gem 'foreman'
  # debugging
  gem 'pry'
end

group :development, :test do
  # restarts server after changes
  gem 'rerun'
  # code analyzer
  gem 'rubocop'
  # code analyzer for rspec tests
  gem 'rubocop-rspec'
end

# Downgraded psych to enable old features
gem 'psych', '< 4'
