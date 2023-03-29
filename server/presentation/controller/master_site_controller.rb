# frozen_string_literal: true

require 'sinatra/json'
require 'rack/protection'
require 'rack/deflater'

require 'presentation/controller/person_controller'

module Presentation
  module Controller
    # Controller that handles default routes and API requests
    # it is the master controller for the entire Application
    class MasterSiteController < Sinatra::Application
      use Rack::Deflater
      use Rack::Protection
      use Rack::Protection::AuthenticityToken
      # middleware should get added before this line
      #
      # controller section
      use PersonController
      # rack specification check
      use Rack::Lint

      get '/' do
        erb :index
      end

      # Verify this.
      # Besides of halting requests on non existent resources,
      # It prevents assets being searched in the controller routes,
      # Avoiding: RuntimeError - downstream app not set; 500
      get '/*' do
        halt 404, 'Not found'
      end
    end
  end
end
