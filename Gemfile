source 'https://rubygems.org'

ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', group: :production
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'rack-cors'
gem 'jbuilder'
gem 'yajl-ruby', require: 'yajl'

group :development, :test do
  gem 'sqlite3'
  gem 'rubocop', require: false
  gem 'faker'
  gem 'pry-byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end
