# frozen_string_literal: true

require 'domain/model/people'

module Presentation
  module Controller
    # Controller that handles requests about Person-related actions
    class PersonController < Sinatra::Base
      # These controllers are tied to the server life-cycle, they do not get created for each request,
      #  they get created as part of the server
      # def initialize(app, *args, &block)
      #   super app, *args, &block
      # end

      get '/persons' do
        people = Domain::People.new
        json people.all.map(&:to_hash)
      end
    end
  end
end
