ENV['RACK_ENV'] = 'test' unless ENV['RACK_ENV']
require 'rubygems'
require 'sinatra'
require 'spec'
require 'webrat'

require "#{File.dirname(__FILE__)}/../../../application"
require "#{File.dirname(__FILE__)}/../../factory"

Webrat.configure do |config|
  config.mode = :mechanize
end

class String
  def strip_html
    gsub(/<\/?[^>]*>/, "")
  end
end

class MechanizeWorld < Webrat::MechanizeSession
  include Webrat::Matchers
  include Factory
  include Application::Helpers
end

World do
  Before do
    Sham.reset
    SERVER.database(COUCHDB).recreate! rescue nil
  end
  After { SERVER.database(COUCHDB).delete! rescue nil } 
  MechanizeWorld.new
end
