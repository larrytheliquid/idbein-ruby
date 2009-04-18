require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'webrat'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
require 'application'
require 'spec/factory'

Spec::Runner.configure do |config|
  config.include Webrat::Matchers, :type => :views
  config.include Factory

  config.before { SERVER.database(COUCHDB).create! rescue nil }
  config.after { SERVER.database(COUCHDB).delete! rescue nil }    
end
