ENV['RACK_ENV'] = 'test'
require 'rubygems'
require 'sinatra'
require 'spec'

require "#{File.dirname(__FILE__)}/../../application"
require "#{File.dirname(__FILE__)}/../factory"

Spec::Runner.configure do |config|
  config.include Factory
  
  config.before do
    Sham.reset
    SERVER.database(COUCHDB).recreate! rescue nil
  end
  config.after { SERVER.database(COUCHDB).delete! rescue nil }
end
