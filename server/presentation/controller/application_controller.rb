# frozen_string_literal: true
require 'util/loggable'

module Presentation
  module Controller
    # Base controller intended to hold common logic
    # All custom controllers extend this
    class ApplicationController < Sinatra::Base
      include Logging::Loggable

      error StandardError do
        error_message = env['sinatra.error'].message
        logger.error error_message
        'Sorry there was a nasty error - ' + error_message
      end

      not_found do
        'This is nowhere to be found.'
      end
    end
  end
end
