require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'environment'
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  get '/' do
    @polls = Poll.all
    erb :get_polls
  end

  get '/:id' do
    @poll = Poll.get(params[:id])
    erb :get_poll
  end

  post '/' do
    Poll.new(params[:poll]).save
    redirect '/'
  end
end
