# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '3.0.0'



gem 'pg'
gem 'sinatra'
gem 'sinatra-flash'
gem 'bcrypt'
gem 'bootstrap', '~> 5.0.1'
gem 'puma'


group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rubocop', '0.79.0'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'sinatra-contrib'
end
