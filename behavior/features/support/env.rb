require 'rubygems'
require 'sinatra'
require 'spec'
require 'webrat'

require "#{File.dirname(__FILE__)}/../../../application"
require "#{File.dirname(__FILE__)}/../../factory"

Webrat.configure do |config|
  config.mode = :selenium
  config.application_port = 9292
  config.application_environment = :test
  config.application_framework = :sinatra
end

class SeleniumWorld < Webrat::SeleniumSession
  include Webrat::Selenium::Matchers
  include Factory
  include Application::Helpers
end

World do
  Before do
    Sham.reset
    SERVER.database(COUCHDB).recreate! rescue nil
  end
  After { SERVER.database(COUCHDB).delete! rescue nil }
  SeleniumWorld.new
end
