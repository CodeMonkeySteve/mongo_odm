namespace :db do
  unless Rake::Task.task_defined?('db:drop')
    desc 'Drops all the collections from the database'
    task :drop => :environment do
      MongoODM.database.collections.select { |c| c.name !~ /system/ }.each(&:drop)
    end
  end

  unless Rake::Task.task_defined?('db:seed')
    desc 'Load the seed data from db/seeds.rb'
    task :seed => :environment do
      seed_file = File.join( Rails.root, 'db', 'seeds.rb' )
      load(seed_file)  if File.exist?(seed_file)
    end
  end

  unless Rake::Task.task_defined?('db:setup')
    desc 'Create the database, and initialize with the seed data'
    task :setup => [ 'db:seed' ]
  end

  unless Rake::Task.task_defined?('db:reseed')
    desc 'Delete data and seed'
    task :reseed => [ 'db:drop', 'db:seed' ]
  end
end
