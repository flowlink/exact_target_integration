source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'capistrano'

gem 'httparty'
gem 'json'
gem 'nokogiri'
gem 'exact-target', :git => 'https://github.com/andreibondarev/exact-target.git', :branch => 'improvements'

group :development do
  gem 'shotgun'
  gem 'awesome_print'
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'vcr', '2.7'
  gem 'rspec'
  gem 'webmock'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rack-test'
end

group :production do
  gem 'foreman'
  gem 'unicorn'
end

gem 'endpoint_base', :git => 'https://github.com/spree/endpoint_base.git'
