# frozen_string_literal: true
require 'util/loggable'

module Presentation
  module Controller
    # Base controller intended to hold common logic
    # All custom controllers extend this
    class ApplicationController < Sinatra::Base
      include Logging::Loggable

      error StandardError do
        error = env['sinatra.error']
        logger.error "class=#{error.class} message=#{error.message.inspect} backtrace=#{error.backtrace[..5].join('#')}"
        'Sorry there was a nasty error'
      end

      not_found do
        'This is nowhere to be found.'
      end
    end
  end
end
