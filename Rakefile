namespace :db do
  
  desc 'Environment'
  task :environment do
    require 'sequel'
    DB = Sequel.connect ENV['DATABASE_URL']
  end
  
  desc 'Seed database'
  task seed: :environment do
    require_relative 'db/seed'
  end
  
  namespace :migrate do
    
    desc 'Environment'
    task environment: :'db:environment' do
      require 'sequel_postgresql_triggers'
      Sequel.extension :migration
      MIGRATE_DIR = 'db/migrate'
    end
    
    desc 'Automigrate database'
    task auto: :environment do
      Sequel::Migrator.run DB, MIGRATE_DIR, target: 0
      Sequel::Migrator.run DB, MIGRATE_DIR
    end
    
    desc 'Migrate up'
    task :up, [:target] => :environment do |t, args|
      Sequel::Migrator.run DB, MIGRATE_DIR, target: args[:target]
    end
    
  end
  
  task migrate: 'migrate:up'
  
end
