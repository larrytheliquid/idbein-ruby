require 'rubygems'
require 'sinatra'
require 'spec'
require 'webrat'

require "#{File.dirname(__FILE__)}/../../../application"
require "#{File.dirname(__FILE__)}/../../factory"

Webrat.configure do |config|
  config.mode = :mechanize
end

class MechanizeWorld < Webrat::MechanizeSession
  include Webrat::Matchers
  include Factory
  include Application::Helpers
end

class String
  def strip_html
    gsub(/<\/?[^>]*>/, "")
  end
end

World do
  Before { SERVER.database(COUCHDB).create! rescue nil }
  After { SERVER.database(COUCHDB).delete! rescue nil } 
  MechanizeWorld.new
end
