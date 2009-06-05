require 'rubygems'
require 'sinatra'
require 'spec'
require 'webrat'
require 'rack/test'

app_file = "#{File.dirname(__FILE__)}/../../../application"
require app_file
require "#{File.dirname(__FILE__)}/../../factory"

Webrat.configure do |config|
  config.mode = :rack_test
#   config.mode = :selenium
#   config.application_port = 9292
#   config.application_environment = :test
#   config.application_framework = :sinatra
end

# class Domination < Webrat::SeleniumSession
#   include Webrat::Selenium::Matchers
#   include Factory
#   include Application::Helpers
# end

class Domination
  include Rack::Test::Methods
  include Webrat::Methods  
  include Webrat::Matchers
  include Factory
  include Application::Helpers

  alias response last_response
  def app() Application.new end
end

Before do
  Sham.reset
  SERVER.database(COUCHDB).recreate! rescue nil
  5.times { new_user.save! }
end

After do
  SERVER.database(COUCHDB).delete! rescue nil
  visit '/freshstart'
end

World { Domination.new }
