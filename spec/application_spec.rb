require "#{File.dirname(__FILE__)}/spec_helper"

context 'Main list of polls' do
  include Rack::Test::Methods
  def app
    Application.new
  end
  
  describe 'GET /' do
    def do_get
      Poll.new(:title => 'find me 1').save
      Poll.new(:title => 'find me 2').save
      get '/'
    end
    before { do_get }

    it { last_response.should be_successful }
    
    it 'should list all polls' do
      last_response.should contain('find me 1')
      last_response.should contain('find me 2')
    end
  end

  describe 'POST / with valid attributes' do
    def do_post(attributes={})
      post '/', {:poll => poll_attributes(attributes)}
    end

    it { do_post; last_response.should be_redirect }

    it 'should create a new post that shows up in the list' do
      do_post(:title => 'find me')
      follow_redirect!
      last_response.should contain('find me')
    end
  end
end

