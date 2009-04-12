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

module Factory
  def poll_attributes(attributes={})
    {:title => 'test poll',
     :description => 'test description'
    }.merge(attributes)
  end
  
  def new_poll(attributes={})
    Poll.new(poll_attributes attributes)
  end
end

require 'webrat'
Spec::Runner.configure do |config|
  config.mock_with :mocha
  config.include Webrat::Matchers, :type => :views
  config.include Factory

  config.before do
    db = SERVER.database(COUCHDB)
    db.create! rescue nil
  end

  config.after do
    db = SERVER.database(COUCHDB)
    db.delete! rescue nil
  end
end
