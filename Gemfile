# Use `bundle install` in order to install these gems
source 'http://rubygems.org'

gem 'activesupport'
gem 'activemodel'
gem 'mongo'
gem 'bson_ext'
gem 'tzinfo'

group :development do
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'jeweler'
  gem 'rcov'
  gem 'rspec'
  gem 'yard'
  gem 'watchr'

  gem 'ruby-debug', :platforms => :ruby_18
  platforms :ruby_19 do
    gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
    gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
    gem 'ruby-debug19', :require => 'ruby-debug'
  end
end
