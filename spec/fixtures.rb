require 'rubygems'
require 'sinatra'
require 'application'
require 'spec/factory'

Sinatra::Base.set :environment, :test
include Factory

20.times do
puts   new_vote.save
end
