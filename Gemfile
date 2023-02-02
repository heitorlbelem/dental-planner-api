# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.0.3'
gem 'bootsnap', require: false
gem 'cpf_cnpj'
gem 'devise'
gem 'devise-jwt'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.3'
gem 'rack-cors'
gem 'rails', '~> 7.0.4', '>= 7.0.4.1'
gem 'rubocop'
gem 'rubocop-rails'
gem 'rubocop-rspec'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'awesome_rails_console'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.17'
  gem 'rspec-rails', '~> 5.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'shoulda-matchers', '~> 4.5'
  gem 'simplecov', '~> 0.21.2', require: false
end

group :development, :test do
  gem 'hirb'
  gem 'hirb-unicode-steakknife', require: 'hirb-unicode'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
end
