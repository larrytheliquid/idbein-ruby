require 'rubygems'
require 'sinatra'
# require 'environment'

class Poll < Sinatra::Base
  get '/' do
    'hello world'
  end
end
