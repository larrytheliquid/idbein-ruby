require 'rubygems'
require 'sinatra'
require 'application'
set :run, false
set :environment, :development
set :static, true
run Application

