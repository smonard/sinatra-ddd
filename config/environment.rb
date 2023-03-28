# frozen_string_literal: true

root = File.expand_path(File.join(__dir__, '..'))
$LOAD_PATH.unshift File.join(root, 'server')

require 'util/loggable'

configure :development, :production do
  enable :static
  enable :logging
  enable :sessions
  enable :protection
  disable :method_override
  disable :run

  set :sessions,
      httponly: true,
      secure: production?,
      expire_after: 86_400, # 1 day
      secret: ENV['SESSION_SECRET']
  set :session_store, Rack::Session::Pool
  set :views, "#{settings.root}/server/presentation/view"
  set :ssl, production?
  set :public_folder, "#{settings.root}/server/presentation/view/build"
end

configure :development do
  enable :show_exceptions
  enable :raise_errors
end

configure :production do
  disable :show_exceptions
  disable :raise_errors
end

configure :test do
  enable :logging
  enable :show_exceptions
  enable :raise_errors
  enable :sessions
  set :views, "#{settings.root}/int/view"
end
