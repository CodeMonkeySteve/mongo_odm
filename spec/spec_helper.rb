# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'rubygems'
require 'rspec'
require 'mongo_odm'
require 'database_cleaner'
#require File.expand_path('../../config/environment', __FILE__)

MongoODM.config.database = 'mongo_odm-test'

# Load all example models
MODELS_PATH = File.join(File.dirname(__FILE__), "models")
Dir[ File.join(MODELS_PATH, "*.rb") ].sort.each { |file| require file }

RSpec.configure do |config|
  # db cleaner
  class ::Mongoid
    def self.database()  MongoODM.database  end
  end
  config.before(:suite) do
    DatabaseCleaner.orm = :mongoid
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.clean
  end
end
