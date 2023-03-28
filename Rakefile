# frozen_string_literal: true

require 'dotenv/load'
load 'config/db/database.rake'

ENV['APP_ENV'] = ENV['RACK_ENV']

task default: %w[run]

task :run do
  case ENV['RACK_ENV']
  when 'development'
    Rake::Task['rundev'].invoke
  when 'test'
    Rake::Task['test'].invoke
  when 'production'
    Rake::Task['runsys'].invoke
  end
end

task :runsys do
  sh "cd ./server/presentation/view && \
      ./node_modules/.bin/webpack --config webpack.config.js --mode #{ENV['APP_ENV']} && \
      cd -"
  bundle exec 'puma'
end

task :rundev do
  bundle exec 'foreman start'
end

task :test do
  ENV['RACK_ENV'] = ENV['APP_ENV'] = 'test'
  sh 'bundle exec rspec'
  bundle exec 'cucumber'
end

task :routes do
  $LOAD_PATH.unshift File.join(File.expand_path(File.join(__dir__, '.')), 'server')
  @routes = {}

  def map(relative_path)
    @current_map = relative_path
    @routes[@current_map] = {}
    yield
  end

  def middleware_controllers(klass)
    klass.instance_variable_get(:@middleware).collect { |arr| arr[0] }
         .filter { |mid| mid.instance_variable_defined?(:@routes) }
  end

  def register_route(klass)
    sub_routes = klass.routes.transform_values do |paths|
      paths.map { |path| "#{@current_map.chomp('/')}#{path[0]}" }
    end
    @routes[@current_map].merge!(klass.to_s => sub_routes)
  end

  def run(main_klass)
    klasses = [main_klass] + middleware_controllers(main_klass)
    klasses.each { |klass| register_route klass }
  end

  require 'presentation/controller/master_site_controller'

  map('/') { run Presentation::Controller::MasterSiteController }

  print_pretty @routes
end

def print_pretty(routes_hash)
  routes_hash.each do |main, sub|
    print "#{main}  =>"
    sub.each do |controller, methods|
      puts "   #{controller}"
      methods.each do |method, occurences|
        puts "\t\t#{method}"
        occurences.each { |route| puts "\t\t\t\t#{route}" }
      end
    end
  end
end
