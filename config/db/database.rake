# frozen_string_literal: true

require 'active_record'
require 'yaml'
require 'dotenv/load'

namespace :db do
  db_config = YAML.load(File.open('config/db/config.yml'))[ENV['RACK_ENV']]
                  .merge('schema_search_path' => 'public')

  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.connection.create_database(db_config['database']) unless db_config['adapter'].eql? 'sqlite3'
    puts 'Database created.'
  end

  desc 'Apply migrations to the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new('config/db/migrate/', ActiveRecord::SchemaMigration).migrate
    Rake::Task['db:schema'].invoke
    puts 'Database migrated.'
  end

  desc 'Seed database'
  task :seed do
    ActiveRecord::Base.establish_connection(db_config)
    require_relative 'seeds.rb'
  end

  desc 'Reset database'
  task reset: %i[drop create migrate]

  desc 'Create a db schema file'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = 'test'.eql?(ENV["RACK_ENV"])? 'spec/int/db/schema.rb' : 'config/db/schema.rb'
    File.open(filename, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

  desc 'Drop database'
  task :drop do
    ActiveRecord::Base.establish_connection(db_config)
    if db_config['adapter'].eql? 'sqlite3'
      File.delete(db_config['database']) if File.exist?(db_config['database'])
    else
      ActiveRecord::Base.connection.drop_database(db_config['database'])
    end
    puts 'Database deleted.'
  end

  desc 'Rollback migration'
  task :rollback do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new('config/db/migrate/', ActiveRecord::SchemaMigration).rollback
    Rake::Task['db:schema'].invoke
    puts 'Last migration has been reverted.'
  end

  desc 'Generate migration'
  task :new_migration do
    name = ARGV[1] || raise('Specify name: rake db:new_migration migration_name')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = "config/db/migrate/#{timestamp}_#{name}.rb"
    migration_class = name.split('_').map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<~FILE
        # frozen_string_literal: true
        
        # Migration for #{name}
        class #{migration_class} < ActiveRecord::Migration[7.0]
          def change

          end
        end
      FILE
    end

    puts "Migration #{path} created"
    exit # needed to stop other tasks
  end
end
