require 'rubygems'
require 'sinatra'
require 'application'
require 'test/factory'
include Factory

SERVER.database(COUCHDB).recreate!
20.times { new_vote.save }
