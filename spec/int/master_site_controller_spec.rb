# frozen_string_literal: true

require 'presentation/controller/master_site_controller'
require 'rack/test'

RSpec.describe Presentation::Controller::MasterSiteController do
  include Rack::Test::Methods

  def app
    Presentation::Controller::MasterSiteController
  end

  context 'GET index' do
    context 'valid request' do
      it 'returns a smile' do
        get '/'

        expect(last_response).to be_ok
        expect(last_response.body).to eq('<html><head></head><body>:)</body></html>')
      end

      it 'halts with 400 when no resource was found' do
        get "/#{Faker::Name.last_name}"

        expect(last_response).to be_not_found
        expect(last_response.body).to eq('This is nowhere to be found.')
      end
    end
  end
end
