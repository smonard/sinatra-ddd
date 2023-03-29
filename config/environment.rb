# frozen_string_literal: true

# this config could go in server/presentation/controller/application_controller.rb
Sinatra::Base.class_eval do
  configure :development, :test do
    enable :logging
    enable :show_exceptions
    enable :reload_templates
    enable :dump_errors

    set :show_exceptions, :after_handler
  end

  configure :production do
    disable :logging
    disable :show_exceptions
    disable :reload_templates
    disable :method_override
    disable :run
  end

  configure :test do
    set :views, "#{settings.root}/int/view"
  end

  configure do
    enable :static
    enable :protection
    set :root, '.'
    set :views, "#{settings.root}/server/presentation/view"
    set :ssl, production?
    set :public_folder, "#{settings.root}/server/presentation/view/build"
  end
end

# this config could go in server/presentation/controller/master_site_controller.rb
Sinatra::Application.class_eval do
  configure do
    enable :sessions
    set :sessions,
        httponly: true,
        secure: production?,
        expire_after: 86_400, # 1 day
        secret: ENV['SESSION_SECRET']
    set :session_store, Rack::Session::Pool
  end
end
