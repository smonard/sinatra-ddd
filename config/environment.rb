# frozen_string_literal: true
require 'util/loggable'

# this config could go in server/presentation/controller/application_controller.rb
Sinatra::Base.class_eval do
  configure :development, :test do
    enable :show_exceptions
    enable :reload_templates
    enable :dump_errors

    set :show_exceptions, :after_handler
    set :views, "server/presentation/view"
  end

  configure :production do
    disable :show_exceptions
    disable :reload_templates
    disable :method_override
    disable :run
    set :views, "server/presentation/view"
  end

  configure :test do
    set :views, "spec/int/view"
  end

  configure do
    enable :static
    enable :protection

    set :ssl, production?
    set :public_folder, "server/presentation/view/build"
  end
end

# this config could go in server/presentation/controller/master_site_controller.rb
Sinatra::Application.class_eval do
  configure do
    enable :sessions
    disable :logging

    set :sessions,
        httponly: true,
        secure: production?,
        expire_after: 86_400, # 1 day
        secret: ENV['SESSION_SECRET']
    set :session_store, Rack::Session::Pool
  end
end
