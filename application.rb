require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'environment'
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  get '/polls' do
    @polls = Poll.all
    erb :get_polls
  end

  get '/polls/:id' do
    @poll = Poll.get(params[:id])
    erb :get_polls_show
  end

  post '/polls' do
    Poll.new(params[:poll]).save
    redirect '/polls'
  end

  get '/users/new' do
    erb :get_users_new
  end

  post '/users' do
    User.new(params[:user]).save
    redirect '/polls'
  end
end
