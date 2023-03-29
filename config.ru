# frozen_string_literal: true

root = File.expand_path(File.join(__dir__, '.'))
$LOAD_PATH.unshift File.join(root, 'server')

require 'sinatra'
require 'forwardable'
require_relative 'config/environment'
require 'presentation/controller/master_site_controller'

use Rack::Reloader unless settings.production?

map('/') { run Presentation::Controller::MasterSiteController }
