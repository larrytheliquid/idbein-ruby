require "#{File.dirname(__FILE__)}/spec_helper"

describe 'GET /' do
  include Rack::Test::Methods
  
  def app
    Poll.new
  end

  it do
    get '/'
    last_response.should be_successful
  end
end
