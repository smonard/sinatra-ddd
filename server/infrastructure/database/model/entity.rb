# frozen_string_literal: true

require 'active_record'
require 'util/loggable'

module Infrastructure
  # Database module to contain data access logic
  module Database
    extend Logging::Loggable
    # Could exist one config file for each database
    # This way the server could have many databases
    CONFIG_1 = YAML.load(File.open('config/db/config.yml'))[ENV['RACK_ENV']]
                   .merge('schema_search_path' => 'public')

    ActiveRecord::Base.logger = logger

    # Module containing data structures as classes
    module Model
      # Base class for all Entities regarding the database loaded in CONFIG_1
      class Entity < ActiveRecord::Base
        self.abstract_class = true
      end
      # Choose the right db CONFIG for all classes descendants of ENTITY
      Entity.establish_connection(CONFIG_1)

      # class EntitySecondDB < ActiveRecord::Base
      #  self.abstract_class = true
      # end
      # EntitySecondDB.establish_connection(CONFIG_SECOND_DB)
    end
  end
end
