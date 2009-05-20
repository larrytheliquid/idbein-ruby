require "#{File.dirname(__FILE__)}/../../spec_helper"

World do
  def app() Application.new end  
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Factory
end

Before { SERVER.database(COUCHDB).create! rescue nil }
After { SERVER.database(COUCHDB).delete! rescue nil }

# TODO: HACK HACK HACK... why does cucumber not have response helpers
# in its mock response?
class Rack::MockResponse
  include Rack::Response::Helpers
end
