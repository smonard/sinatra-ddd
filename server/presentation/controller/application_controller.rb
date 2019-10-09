# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'

module Presentation
  module Controller
    # Base controller, handles the default route
    class ApplicationController < Sinatra::Application
      set :ssl, -> { !development? }
    end
  end
end
