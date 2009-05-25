ENV['RACK_ENV'] = 'test' unless ENV['RACK_ENV']
require 'rubygems'
require 'sinatra'

require "#{File.dirname(__FILE__)}/application"
run Application

