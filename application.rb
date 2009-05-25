require 'rubygems'
require 'sinatra/base'
require 'couchrest'
require 'environment'
Dir.glob(File.join(File.dirname(__FILE__), 'lib/*.rb')).each {|f| require f }

class Application < Sinatra::Base
  enable :static
  set :root, File.dirname(__FILE__)

  module Helpers
    include Rack::Utils
    alias_method :h, :escape_html
    
    def partial(page, options={})
      erb :"_#{page}", options.merge(:layout => false)
    end

    def current_user
      User.all.last
    end

    def voted_fragment(permalink, username)
      %s{<esi:include src="/polls/#{permalink}/votes/#{username}.fragment"/>}
    end
  end
  
  helpers do
    include Helpers
  end
  
  get '/polls/new' do
    erb :get_polls_new
  end
  
  get '/polls' do
    @polls = Poll.by_updated_at
    erb :get_polls
  end

  get '/polls/:permalink' do
    @poll = Poll.get(params[:permalink])
    erb :get_polls_show
  end

  post '/polls' do
    poll = Poll.new params[:poll]
    poll.user_id = current_user.id
    poll.save!
    redirect '/polls'
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
    erb :get_users_new
  end

  post '/users' do
    User.new(params[:user]).save!
    redirect '/polls'
  end
end
