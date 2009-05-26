ENV['RACK_ENV'] = 'development' unless ENV['RACK_ENV']
require 'rubygems'
require 'sinatra'
require "#{File.dirname(__FILE__)}/../application"
require "#{File.dirname(__FILE__)}/factory"
include Factory
set :run, false

SERVER.database(COUCHDB).recreate!
20.times { new_vote.save! }
