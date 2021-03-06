source 'https://rubygems.org'
#ruby '2.1.2'

# heroku support
gem 'rails_12factor', group: :production

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
gem 'bootstrap-sass',       '3.2.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
 gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

group :development, :test do
  gem 'rspec-rails', '~> 3.1'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
gem 'byebug', group: [:development, :test]
#gem 'pry-rails', group: :development
#gem 'pry', group: :development

gem 'better_errors', group: :development
gem 'binding_of_caller', group: :development

gem 'rest-client'

# gem to read ESRI shape files (gis geo info)
gem 'rgeo-shapefile'
gem 'rgeo'

# read and write geojson files
gem 'rgeo-geojson'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular', '~> 1.4.9'
  gem 'rails-assets-leaflet', '~> 0.7.3'
  gem 'rails-assets-ui-leaflet'
  gem 'rails-assets-angular-simple-logger'
  gem 'rails-assets-Leaflet.awesome-markers'
end

# provides distance calculations
gem 'geokit-rails'
gem 'geokit'

# async jobs
gem 'sidekiq'
gem 'sinatra', require: false # for frontend

# enforce ruby coding style
gem 'rubocop', require: false
