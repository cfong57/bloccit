source 'https://rubygems.org'

#trying to make Guard work properly
require 'rbconfig'
gem 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

#blah blah blah content-length of response body
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 2.3.1.0'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', '~> 2.5.1' #weird error with latest version
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
end

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

gem 'jquery-rails'

# seeding
#:path => "C:/Users/Alex/Desktop/bloc/code/faker"
#:git => "git@github.com:/cfong57/faker.git"
gem 'faker', :git => "git://github.com/cfong57/faker.git"

# security
gem 'devise', '~> 3.0.0'
gem 'figaro'

# permissions
gem 'cancan'

# markdown
gem 'redcarpet'

# stuff for uploading images
gem 'carrierwave'
gem 'mini_magick', '~> 3.5.0'
gem 'fog'

# pagination
gem 'will_paginate', '~> 3.0'

# universal authorization
gem 'omniauth'
gem 'omniauth-facebook'

# for possible future improvements
# gem 'simple_form'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
