require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
require 'application'

require 'webrat'
Spec::Runner.configure do |config|
  config.mock_with :mocha
  config.include Webrat::Matchers, :type => :views
end
