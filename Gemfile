# Use `bundle install` in order to install these gems
source 'http://rubygems.org'

gem "activesupport", "~>3.0.3"
gem "activemodel", "~>3.0.3"
gem "mongo", "~>1.2.0"
gem "bson_ext", "~>1.2.0"
gem "will_paginate", "~> 3.0.pre"
gem "tzinfo", "~>0.3.24"

group :development do
  gem 'autotest'
  gem 'database_cleaner'
  gem 'jeweler', '~>1.5.2'
  gem 'rcov', '~>0.9.9'
  gem 'rspec', '2.4.0'
  gem 'yard', '~>0.6.4'
  gem 'watchr', '~>0.7'

  if RUBY_VERSION =~ /1.9/
    gem 'ruby-debug19', :require => 'ruby-debug'
  else
    gem 'ruby-debug'
  end
end
