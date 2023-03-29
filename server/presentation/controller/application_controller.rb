# frozen_string_literal: true

module Presentation
  module Controller
    # Base controller intended to hold common logic
    # All custom controllers extend this
    class ApplicationController < Sinatra::Base
      error StandardError do
        'Sorry there was a nasty error - ' + env['sinatra.error'].message
      end

      not_found do
        'This is nowhere to be found.'
      end
    end
  end
end
