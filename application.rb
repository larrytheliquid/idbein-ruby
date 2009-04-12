require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'environment'
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  get '/' do
    'hello world'
  end
end
