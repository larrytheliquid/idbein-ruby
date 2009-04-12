require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'webrat'
require 'faker'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
require 'application'

module Factory
  def poll_attributes(attributes={})
    {:title => Faker::Lorem.sentence,
     :description => Faker::Lorem.paragraph
    }.merge(attributes)
  end
  
  def new_poll(attributes={})
    Poll.new(poll_attributes attributes)
  end
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
  config.include Webrat::Matchers, :type => :views
  config.include Factory

  config.before { SERVER.database(COUCHDB).create! rescue nil }
  config.after { SERVER.database(COUCHDB).delete! rescue nil }    
end
