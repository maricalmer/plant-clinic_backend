source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include? '/'
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.5'

gem 'sprockets', '~> 3.7.2'
gem 'bcrypt', '3.1.13'
gem 'bootsnap', '1.4.5',require: false
gem 'puma', '~> 3.12'
gem 'rack-cors', '2.0.1', require: 'rack/cors'
gem 'rails', '~> 6.0.2.1'
gem 'pg'
gem 'validate_url', '1.0.8'

gem 'graphql', '1.10.0'
gem 'graphql-query-resolver', '0.2.0'
gem 'search_object', '1.2.3'
gem 'search_object_graphql', '0.3.1'

group :development, :test do
  gem 'byebug', '11.1.0', platforms: %i(mri mingw x64_mingw)
  gem 'factory_bot_rails', '5.1.1'
  gem 'graphiql-rails', '1.5.0'
  gem 'rubocop', '0.79.0'
  gem "dotenv-rails"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem "dockerfile-rails", ">= 1.5", :group => :development
