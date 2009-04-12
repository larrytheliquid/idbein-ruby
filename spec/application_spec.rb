require "#{File.dirname(__FILE__)}/spec_helper"

context 'Main list of polls' do
  include Rack::Test::Methods
  def app
    Application.new
  end
  
  describe 'GET /' do
    subject { get '/' ; last_response }

    it { should be_successful }
    it { should contain('hello world') }
  end
end

