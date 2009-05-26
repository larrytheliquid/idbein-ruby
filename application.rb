require 'rubygems'
require 'sinatra/base'
require 'couchrest'
require 'environment'
require "#{File.dirname(__FILE__)}/middleware/esi"
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  enable :static
  set :root, File.dirname(__FILE__)
  use Rack::ESI

  module Helpers
    include Rack::Utils
    alias_method :h, :escape_html
    
    def partial(page, options={})
      erb :"_#{page}", options.merge(:layout => false)
    end

    def current_user
      User.all.last
    end

    def esi_include(path)
      %{<esi:include src="#{path}.fragment"/>}
    end
  end
  include Helpers
  
  get '/polls/new' do
    @poll = Poll.new
    erb :get_polls_new
  end
  
  get '/polls' do
    @polls = Poll.by_updated_at
    erb :get_polls
  end

  post '/polls' do
    @poll = Poll.new params[:poll]
    @poll.user_id = current_user.id
    if @poll.valid?
      @poll.save!
      redirect '/polls'
    else
      erb :get_polls_new
    end
  end  

  get '/polls/:permalink/votes/:username.fragment' do
    @poll = Poll.get params[:permalink]
    vote = Vote.new(:user_id => params[:username],
                    :poll_id => params[:permalink])
    @voted = Vote.get(vote.vote_hash) rescue false
    erb :get_polls_votes_show, :layout => false
  end

  put '/polls/:permalink/votes/:username' do
    poll = Poll.get(params[:permalink])
    user = User.get(params[:username])
    user.vote! poll
    "#{user.username} successfully voted for '#{poll.title}'"
  end

  get '/users/new' do
    @user = User.new
    erb :get_users_new
  end

  post '/users' do
    @user = User.new(params[:user])
    if @user.valid?
      @user.save!
      redirect '/polls'
    else
      erb :get_users_new
    end
  end
end
