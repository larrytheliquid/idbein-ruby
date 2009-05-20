require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'webrat'

require 'application'
require 'test/factory'

Application.set :environment, :test
Application.set :run, false
Application.set :raise_errors, true
Application.set :logging, false

World do
  def app() Application.new end  
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Factory

  Before { SERVER.database(COUCHDB).create! rescue nil }
  After { SERVER.database(COUCHDB).delete! rescue nil }
end

# TODO: HACK HACK HACK... why does cucumber not have response helpers
# in its mock response?
class Rack::MockResponse
  include Rack::Response::Helpers
end
