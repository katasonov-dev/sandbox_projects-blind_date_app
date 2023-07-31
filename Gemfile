source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis", "~> 4.0"
gem 'will_paginate', '~> 4.0'
gem 'devise'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem "web-console"
end
