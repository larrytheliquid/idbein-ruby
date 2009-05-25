require 'rubygems'
require 'sinatra'
require "#{File.dirname(__FILE__)}/../application"
require "#{File.dirname(__FILE__)}/factory"
include Factory

SERVER.database(COUCHDB).recreate!
20.times { new_vote.save }
