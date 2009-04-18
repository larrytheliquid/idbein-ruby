require 'rubygems'
require 'sinatra'
set :run, false
set :environment, :development
set :static, true
require 'application'
run Application

