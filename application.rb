require 'rubygems'
require 'sinatra/base'
require 'couchrest'
require 'environment'
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  enable :static
  set :root, File.dirname(__FILE__)
  
  helpers do
   def partial(page, options={})
     erb :"_#{page}", options.merge(:layout => false)
   end

   def current_user
     User.all.last
   end
  end
      
  get '/polls' do
    @polls = Poll.all
    erb :get_polls
  end

  get '/polls/:permalink' do
    @poll = Poll.get(params[:permalink])
    erb :get_polls_show
  end

  post '/polls' do
    Poll.new(params[:poll]).save
    redirect '/polls'
  end

  post '/polls/:permalink/votes/:username' do
   poll = Poll.get(params[:permalink])
   user = User.get(params[:username])
   user.vote! poll
   "#{user.username} successfully voted for '#{poll.title}'"
  end

  get '/users/new' do
    erb :get_users_new
  end

  post '/users' do
    User.new(params[:user]).save
    redirect '/polls'
  end
end
