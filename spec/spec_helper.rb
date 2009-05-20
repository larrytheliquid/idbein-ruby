require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'webrat'

require 'application'
require 'spec/factory'

Application.set :environment, :test
Application.set :run, false
Application.set :raise_errors, true
Application.set :logging, false

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.include Factory

  def app
    Application.new
  end

  config.before { SERVER.database(COUCHDB).create! rescue nil }
  config.after { SERVER.database(COUCHDB).delete! rescue nil }
end
